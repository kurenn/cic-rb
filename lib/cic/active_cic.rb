require "hashie"
require "httparty"
require "cic/errors"
require "active_support/inflector"

module ActiveCic
  class Base
    attr_accessor :attributes
    attr_reader :raw_attributes

    BASE_URL = "api.nl.cic.mx/0/nl".freeze

    include HTTParty

    base_uri BASE_URL

    def initialize(hash)
      self.attributes = Hashie::Mash.new(hash)
      @raw_attributes = hash
    end

    def method_missing(name, *args)
      attributes.send(name, args)
    rescue NoMethodError
      super
    end

    def self.all
      class_name = pluralize_child_class_name
      response = get("/#{class_name}.json")
      if response.success?
        response.parsed_response[class_name].map { |hash| new(hash) }
      else
        raise_exception(response.code, response.body)
      end
    end

    private

    def self.raise_exception(code, body)
      raise Cic::Exception::ServerError.new(code, body) if code >= 500
      raise Cic::Exception::ClientError.new(code, body) if code < 500
    end

    def self.pluralize_child_class_name
      to_s.split("::").last.downcase.pluralize
    end
  end
end
