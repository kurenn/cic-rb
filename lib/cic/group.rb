$: << "lib"
require "cic/active_cic"

module Cic
  class Group < ActiveCic::Base
    def initialize(hash)
      super(hash)
    end

    def id
      attributes.id
    end
  end
end
