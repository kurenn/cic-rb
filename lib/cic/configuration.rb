module Cic
  class Configuration
    attr_accessor :base_url
  end
  class << self
    attr_accessor :configuration
  end
  
  def self.configure
    self.configuration ||= Configuration.new
    yield configuration 
  end
end
