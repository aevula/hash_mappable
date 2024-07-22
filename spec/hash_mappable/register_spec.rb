# frozen_string_literal: true

RSpec.describe(HashMappable::Register) do
  let(:instance) { described_class.new }
  let(:source2)  { {}                  }
  let(:source)   { { test: source2 }   }

  describe '#to' do
    it do
      expect { instance.to(:test) }
        .to change { instance.chain(:key).count }
        .from(0).to(1)
    end
  end

  describe '#from' do
    it do
      expect { instance.from(:test) }
        .to change { instance.chain(:value).count }
        .from(0).to(1)
    end
  end

  describe '#unpack' do
    context 'without object' do
      it do
        expect(instance.unpack(source)).to be_a(Array)
      end
    end

    context 'with object' do
      it do
        object = {}
        instance.unpack(source, object)

        expect(object).to be_empty
      end

      it do
        allow(instance).to receive(:resolved_key).and_return(:test)

        object = {}
        instance.unpack(source, object)

        expect(object).to eq({ test: nil })
      end
    end
  end

  describe '#fetch' do
    before { allow(instance).to receive(:fetch).and_call_original }

    context 'with 1 fetcher' do
      it do
        instance.from(:test)
        instance.unpack(source)

        expect(instance).to have_received(:fetch).with(source, :test)
      end
    end

    context 'with > 1 fetchers' do
      it do
        allow(instance).to receive(:fetch).with(source, :test).and_call_original

        instance.from(:test).from(:test)
        instance.unpack(source)

        expect(instance).to have_received(:fetch).with(source2, :test)
      end
    end
  end
end
