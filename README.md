# ActiveSupport::Cache::NamespacedStore

A simple ActiveSupport::Cache implementation that wraps another implementation to prefix/namespace keys.

## Usage

```ruby
Rails.cache.write('prefix:1', 'foo')

cache = ActiveSupport::Cache::NamespacedStore.new 'prefix:', Rails.cache
cache.read '1'
# => 'foo'
```

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
