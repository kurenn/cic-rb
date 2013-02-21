$: << 'lib'
require "cic/version"

#include Cic modules
require "cic/configuration"
require "cic/errors"

module Cic
  BASE_URL = "http://api.nl.cic.mx/0/nl/reports.json"
  self.configure do |config|
    config.base_url = BASE_URL 
  end
end
