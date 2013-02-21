require 'httparty'
require 'hashie'

module Cic
  class Category

    BASE_URL = "api.nl.cic.mx/0/nl"

    attr_accessor :attributes
    attr_reader :raw_attributes

    include HTTParty

    base_uri BASE_URL

    def initialize(category_hash)
      self.attributes = Hashie::Mash.new(category_hash) 
      @raw_attributes = category_hash
    end

    def self.all
      response = self.get("/categories.json") 
      if response.success?
        response.parsed_response['categories'].map { |category_hash| self.new(category_hash) } 
      else
        raise Cic::Exception::ServerError.new(response.code, response.body) if response.code >= 500
        raise Cic::Exception::ClientError.new(response.code, response.body) if response.code < 500
      end
    end

    %w(id type).each do |attr|
      define_method attr do
        self.attributes.send(attr)
      end
    end

    def method_missing(name, *args)
      self.attributes.send(name, args)
    end
  end
end
