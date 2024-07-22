# frozen_string_literal: true

RSpec.describe(HashMappable) do
  describe '::VERSION' do
    it do
      expect(HashMappable::VERSION).to be_truthy
    end
  end

  context 'when included' do
    before do
      stub_const('Klass', Class.new)
      Klass.class_eval { include(HashMappable::Core) }
    end

    it 'includes Core' do
      expect(Klass).to include(HashMappable::Core)
    end

    it 'not includes base module' do
      expect(Klass).not_to(be_const_defined(:VERSION))
    end
  end
end
