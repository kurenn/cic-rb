$: << 'lib'
require 'cic/active_cic'

module Cic
  class Category < ActiveCic::Base

    def initialize(hash)
      super(hash)
    end

    %w(id type).each do |attr|
      define_method attr do
        self.attributes.send(attr)
      end
    end
  end
end
