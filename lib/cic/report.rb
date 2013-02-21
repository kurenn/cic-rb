require 'httparty'
require 'hashie'

module Cic
  class Report

    BASE_URL = "api.nl.cic.mx/0/nl"

    attr_accessor :attributes
    attr_reader :raw_attributes

    include HTTParty

    base_uri BASE_URL

    def initialize(report_hash)
      self.attributes = Hashie::Mash.new(report_hash) 
      @raw_attributes = report_hash
    end

    def self.find(ticket)
      response = self.get("/reports.json") 
      if response.success?
        report_hash = response.parsed_response["reports"].select { |report| report['ticket'] == ticket }.first 
        report_hash ? self.new(report_hash) : nil
       else
        raise Cic::Exception::ServerError.new(response.code, response.body) if response.code >= 500
        raise Cic::Exception::ClientError.new(response.code, response.body) if response.code < 500
      end
    end

    def self.all
      response = self.get("/reports.json") 
      if response.success?
        response.parsed_response['reports'].map { |report_hash| self.new(report_hash) } 
      else
        raise Cic::Exception::ServerError.new(response.code, response.body) if response.code >= 500
        raise Cic::Exception::ClientError.new(response.code, response.body) if response.code < 500
      end
    end

    def self.where(params = {})
      response = self.get("/reports.json", query: params) 
      if response.success?
        response.parsed_response['reports'].map { |report_hash| self.new(report_hash) } 
       else
        raise Cic::Exception::ServerError.new(response.code, response.body) if response.code >= 500
        raise Cic::Exception::ClientError.new(response.code, response.body) if response.code < 500
      end
        
    end

    def method_missing(name, *args)
      self.attributes.send(name, args)
    end
  end
end
