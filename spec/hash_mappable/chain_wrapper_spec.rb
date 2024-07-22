# frozen_string_literal: true

RSpec.describe(HashMappable::ChainWrapper) do
  let(:instance)   { described_class.new }
  let(:chain_name) { :test               }
  let(:block)      { proc { :test }      }
  let(:source)     { {}                  }

  describe '#chain!' do
    it do
      expect(instance.chain!(chain_name, &block)).to be(instance)
    end
  end

  describe '#unchain' do
    it do
      allow(block).to receive(:call).and_call_original

      instance.chain!(chain_name, &block)
      instance.unchain(chain_name, source)

      expect(block).to have_received(:call).with(nil, source, 0)
    end
  end
end
