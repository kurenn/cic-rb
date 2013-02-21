require 'spec_helper'
require 'cic/configuration'

describe Cic::Configuration do
  it { should respond_to(:base_url) }
end
