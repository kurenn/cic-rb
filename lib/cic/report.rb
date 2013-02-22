$: << 'lib'
require 'cic/active_cic'

module Cic
  class Report < ActiveCic::Base

    def initialize(hash)
      super(hash) 
    end

    def self.find(ticket)
      response = self.get("/reports.json") 
      if response.success?
        report_hash = response.parsed_response["reports"].select { |report| report['ticket'] == ticket }.first 
        report_hash ? self.new(report_hash) : nil
       else
        raise_exception(response.code, response.body)
      end
    end

    def save 
      self.class.post("/reports.json", body: self.raw_attributes ) 
      true #POST always finds its way...
    end

    def self.where(params = {})
      response = self.get("/reports.json", query: params) 
      if response.success?
        response.parsed_response['reports'].map { |report_hash| self.new(report_hash) } 
       else
        raise_exception(response.code, response.body)
      end
    end
  end
end
