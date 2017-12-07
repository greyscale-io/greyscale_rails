module GreyscaleRails
  class Railtie < Rails::Railtie
    config.greyscale = ActiveSupport::OrderedOptions.new

    config.greyscale.config_path = "config/greyscale.yml"

    initializer "greyscale.configure" do | app |

      load_config!( app )

      GreyscaleRecord.logger = Rails.logger

      data_store = GreyscaleRecord::DataStore::Engine.new config.greyscale.data_driver

      GreyscaleRecord::Base.data_store = data_store

      if config.greyscale.patch_driver.present?
        GreyscaleRails.patch_driver = config.greyscale.patch_driver
      end

      GreyscaleRecord.live_reload = config.greyscale.live_reload
    end

    private

    def load_config!( app )

      path = config_path( app )

      yaml = YAML.load_file( path ).with_indifferent_access[Rails.env.to_s]

      config.greyscale.data_driver = data_driver yaml

      if yaml[:revision_root].present?
        config.greyscale.patch_driver = data_driver yaml.merge( data_root: yaml[ :revision_root ] )
      end

      config.greyscale.live_reload = yaml[ :live_reload ] || false

    rescue => e
      raise "Failed to process #{config.greyscale.config_path}. Make sure the file exists and is not malformed. Error: \"#{e}\""
    end

    def config_path( app )
      File.expand_path(config.greyscale.config_path, app.root)
    end

    def data_driver( yaml )
      type = yaml[ :driver ].to_sym
      root = yaml[ :data_root ]

      driver_class = DRIVER_TYPES[type]
      raise "Greyscale Rails error: #{type} is not a valid driver. Please choose from: #{DRIVER_TYPES.keys.join(", ")}" unless driver_class

      driver = driver_class.new root

      if driver.respond_to?( :api_key ) && driver.respond_to?( :api_id )
        driver.api_id = yaml[:api_id]
        driver.api_key = yaml[:api_key]
      end

      driver
    end

    DRIVER_TYPES = { yaml: GreyscaleRecord::Drivers::Yaml,
                     # greyscale: GreyscaleRails::Drivers::Greyscale
                   }
  end
end