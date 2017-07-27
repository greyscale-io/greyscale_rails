require "greyscale_rails/engine"
require 'greyscale_rails/railtie' if defined? Rails

module GreyscaleRails
  autoload :Patchable,  "greyscale_rails/patchable"

  class << self
    attr_accessor :patch_driver
  end
end
