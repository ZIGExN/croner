require 'croner/config'

module Croner
  def self.config
    @config ||= Croner::Config.new
  end
 
  def self.configure(&block)
    yield(config) if block_given?
  end
end
