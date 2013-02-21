require 'httparty'
require 'hashie'

module Cic
  class Group

    BASE_URL = "api.nl.cic.mx/0/nl"

    attr_accessor :attributes
    attr_reader :raw_attributes

    include HTTParty

    base_uri BASE_URL

    def initialize(group_hash)
      self.attributes = Hashie::Mash.new(group_hash) 
      @raw_attributes = group_hash
    end

    def self.all
      response = self.get("/groups.json") 
      if response.success?
        response.parsed_response['groups'].map { |groups_hash| self.new(groups_hash) } 
      else
        raise Cic::Exception::ServerError.new(response.code, response.body) if response.code >= 500
        raise Cic::Exception::ClientError.new(response.code, response.body) if response.code < 500
      end
    end
  end
end
