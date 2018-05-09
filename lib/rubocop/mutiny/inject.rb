#
# Taken from: https://github.com/backus/rubocop-rspec/blob/master/lib/rubocop/rspec/inject.rb
#
module RuboCop
    module Mutiny
      # Because RuboCop doesn't yet support plugins, we have to monkey patch in a
      # bit of our configuration.
      module Inject
        def self.defaults!
          CONFIGS.reduce(nil) do |acc, path|
            path = path.to_s
            hash = ConfigLoader.send(:load_yaml_configuration, path)
            config = Config.new(hash, path)
            puts "configuration from #{path}" if ConfigLoader.debug?
            config = ConfigLoader.merge_with_default(config, path)
            ConfigLoader.instance_variable_set(:@default_configuration, config)
          end
        end
      end
    end
  end
