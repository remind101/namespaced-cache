require 'active_support/cache'

module ActiveSupport::Cache
  # Public: A wrapper around an ActiveSupport::Cache to prefix all keys.
  #
  # Example
  #
  #   cache = ActiveSupport::Cache::PrefixedStore.new 'namespace:', Rails.cache
  class PrefixedStore
    attr_reader :prefix, :store

    def initialize(prefix, store)
      @prefix = prefix
      @store = store
    end

    def read(key, *args, &block)
      store.read(prefixed(key), *args, &block)
    end

    def read_multi(*keys)
      k = keys.map { |key| prefixed(key) }
      store.read_multi(*k).each_with_object(Hash.new) do |t,memo|
        memo[t[0].sub(prefix, '')] = t[1]
      end
    end

    def write(key, *args, &block)
      store.write(prefixed(key), *args, &block)
    end

    def fetch(key, *args, &block)
      store.fetch(prefixed(key), *args, &block)
    end

    def clear
      store.delete_matched(prefix)
    end

    private

    def prefixed(key)
      "#{prefix}#{key}"
    end
  end
end
