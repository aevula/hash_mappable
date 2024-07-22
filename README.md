# HashMappable

HashMappable provides customizable functionality for fetching data from Hash-like objects.

Simple gem with hopefully simple code.

## Installation

```ruby
# Gemfile
gem 'hash_mappable', git:  "https://github.com/aevula/hash_mappable.git"
```

## Basic usage

```ruby
class Model
  include HashMappable

  source_fetcher :source # getter method name

  register(:result_data_key).from(:source_data_key)

  def source
    # actual getter
  end
end

instance = Model.new(source: { source_data_key: 'some_value '})
instance.as_mapped_data # => { result_data_key: 'some_value' }
```

### Configure from initializers

```ruby
# config/initializers/hash_mappable.rb

Model.configure do
  source_fetcher :some_cool_method_name

  register(:url).from(:http_url)
  register(:author).from(:users, :creator, :login)
  register(:author).from(:users).from(:creator).from(:login) # similar to line before
end
```

### Custom Registers

```ruby
# **/awesome_register.rb
class AwesomeRegister < HashMappable::Register
  def capitalize_key
    chain!(:key) { |prev_link_rslt, _source, _link_idx| prev_link_rslt.capitalize }
  end

  def take_first
    chain!(:value) { |prev_link_rslt| prev_link_rslt.first }
  end

  # carefull - there is no rescuing in next links
  def only_green!
    chain!(:value) { |prev_link_rslt, source| prev_link_rslt if source[:green] }
  end
end

# config/initializers/hash_mappable.rb
Model.configure do
  use AwesomeRegister
end
```

### Chains

For now unchaining (fetching data) is supported for 2 chains - `:key` and `:value` (**Hash**Mappable afterall).

You're welcome to create solutions with `HashMappable::ChainWrapper`.

## Gem methods

### Class methods

```ruby
Model.configure(&block)                  # allows to configure outside of class definition
Model.use(register_class)                # defaults to HashMappable::Register
Model.source_fetcher(fetch_method = nil) # getter\setter for source getter method name
Model.register(dst_key)                  # adds new register - src_key == dst_key by default
Model.registers                          # returns configured registers
```

### Instance methods

```ruby
instance.as_mapped_data # returns data from source
```

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
