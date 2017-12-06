$: << "lib"
require "cic/active_cic"

module Cic
  class Report < ActiveCic::Base
    attr_reader :ticket_id

    def initialize(hash)
      super(hash)
    end

    def self.find(ticket)
      response = get("/reports.json")
      if response.success?
        report_hash = response.parsed_response["reports"].select { |report| report["ticket"] == ticket }.first
        report_hash ? new(report_hash) : nil
      else
        raise_exception(response.code, response.body)
      end
    end

    def save
      response = self.class.post("/reports.json", body: raw_attributes)
      if response.success?
        @ticket_id = response.parsed_response["reports"]["ticket"]
        true # POST always finds its way...
      else
        false
      end
    end

    def self.where(params = {})
      response = get("/reports.json", query: params)
      if response.success?
        response.parsed_response["reports"].map { |report_hash| new(report_hash) }
      else
        raise_exception(response.code, response.body)
      end
    end
  end
end
