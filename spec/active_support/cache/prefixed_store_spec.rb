require 'spec_helper'

describe ActiveSupport::Cache::PrefixedStore do
  let(:store) { ActiveSupport::Cache::MemoryStore.new }
  let(:cache) { described_class.new 'prefix:', store }

  before do
    store.clear
  end

  describe '#write' do
    it 'writes to the cache' do
      expect {
        cache.write('key', 'value')
      }.to change { store.read('prefix:key') }.from(nil).to('value')
    end
  end

  describe '#read' do
    context 'when the item is in cache' do
      before do
        store.write('prefix:key', 'value')
      end

      it 'reads the item' do
        expect(cache.read('key')).to eq 'value'
      end
    end
  end

  describe '#read_multi' do
    context 'when no items are in cache' do
      it 'does not blow up' do
        expect(cache.read_multi('key1')).to eq Hash.new
      end
    end

    context 'when the items are in cache' do
      before do
        store.write('prefix:key1', 'value1')
        store.write('prefix:key2', 'value2')
      end

      it 'reads the items' do
        expect(cache.read_multi('key1', 'key2')).to eq 'key1' => 'value1', 'key2' => 'value2'
      end
    end
  end

  describe '#fetch' do
    context 'when the item is not in cache' do
      it 'caches the item' do
        expect {
          cache.fetch('key') do
            'value'
          end
        }.to change { store.read('prefix:key') }.from(nil).to('value')
      end
    end
  end

  describe '#clear' do
    before do
      store.write('prefix:key1', 'value1')
      store.write('key1', 'value1')
    end

    it 'clears prefixed keys' do
      expect {
        cache.clear
      }.to change { store.read('prefix:key1') }.from('value1').to(nil)
    end

    it 'does not clear keys that are not prefixed' do
      expect {
        cache.clear
      }.to_not change { store.read('key1') }.from('value1')
    end
  end
end
