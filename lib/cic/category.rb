$: << "lib"
require "cic/active_cic"

module Cic
  class Category < ActiveCic::Base
    def initialize(hash)
      super(hash)
    end

    # Fields reserved from Hashie override
    %w(id type).each do |attr|
      define_method attr do
        attributes.send(attr)
      end
    end
  end
end
