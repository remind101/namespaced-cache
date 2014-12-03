require 'active_support/cache'

module ActiveSupport::Cache
  # Public: A wrapper around an ActiveSupport::Cache to prefix all keys.
  #
  # Example
  #
  #   cache = ActiveSupport::Cache::NamespacedStore.new 'namespace:', Rails.cache
  class NamespacedStore
    attr_reader :namespace, :store

    def initialize(namespace, store)
      @namespace = namespace
      @store = store
    end

    def read(key, *args, &block)
      store.read(namespaced(key), *args, &block)
    end

    def read_multi(*keys)
      k = keys.map { |key| namespaced(key) }
      store.read_multi(*k).each_with_object(Hash.new) do |t,memo|
        memo[t[0].sub(namespace, '')] = t[1]
      end
    end

    def write(key, *args, &block)
      store.write(namespaced(key), *args, &block)
    end

    def fetch(key, *args, &block)
      store.fetch(namespaced(key), *args, &block)
    end

    def clear
      store.delete_matched(namespace)
    end

    private

    def namespaced(key)
      "#{namespace}#{key}"
    end
  end
end
