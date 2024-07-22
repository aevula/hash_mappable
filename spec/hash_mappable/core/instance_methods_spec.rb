# frozen_string_literal: true

RSpec.describe(HashMappable::Core::InstanceMethods) do
  let(:source_method) { :source }
  let(:source_data)   { {}      }

  before do
    stub_const('Klass', Class.new)
    Klass.class_eval { include HashMappable }
    Klass.source_fetcher(source_method)
    Klass.define_method(source_method) { :test }
  end

  describe '#as_mapped_data' do
    let(:instance) { Klass.new }
    let(:register) { HashMappable::Register.new }

    before { allow(instance).to receive(source_method).and_return(source_data) }

    it do
      instance.as_mapped_data
      expect(instance).to have_received(source_method)
    end

    it do
      allow(HashMappable::Register).to receive(:new).and_return(register)
      allow(register).to receive(:unpack).and_return(nil)

      Klass.register(:test)
      instance.as_mapped_data

      expect(register).to have_received(:unpack).with(source_data, {})
    end
  end
end
