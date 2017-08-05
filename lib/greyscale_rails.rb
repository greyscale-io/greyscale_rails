require "greyscale_rails/engine"
require 'greyscale_record'
require 'hana'
require 'greyscale_rails/railtie'

module GreyscaleRails
  autoload :Patchable,  "greyscale_rails/patchable"

  class << self
    attr_accessor :patch_driver
  end
end
