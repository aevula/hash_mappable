# frozen_string_literal: true

RSpec.describe(HashMappable::Core::ClassMethods) do
  before do
    stub_const('Klass', Class.new)
    Klass.class_eval { include(HashMappable) }

    stub_const('CustomRegister', Class.new(HashMappable::Register))
  end

  describe '#configure' do
    context 'without block' do
      it do
        expect { Klass.configure }
          .not_to(raise_error)
      end
    end
  end

  describe '#use' do
    it do
      Klass.configure { use(CustomRegister) }
      expect(Klass.instance_variable_get(:@register_class)).to be(CustomRegister)
    end
  end

  describe '#register' do
    it do
      Klass.register(:test)
      expect(Klass.instance_variable_get(:@register_class)).to be(HashMappable::Register)
    end

    describe 'custom register' do
      let(:register) { CustomRegister.new }

      before do
        allow(CustomRegister).to receive(:new).and_return(register)
        allow(register).to receive(:to).and_return(register)
      end

      it do
        Klass.configure do
          use(CustomRegister)
          register(:test)
        end

        expect(register).to have_received(:to)
      end
    end
  end

  describe '#source_fetcher' do
    let(:fetch_method) { :test }

    it do
      expect(Klass.source_fetcher(fetch_method)).to be(fetch_method)
    end
  end
end
