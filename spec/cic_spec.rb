require 'spec_helper'
require 'cic'

describe Cic do
  it { should respond_to(:configure) }
  it { should respond_to(:configuration) }

  before do
    @cic = Cic.configure do |config|
      config.base_url = Cic::BASE_URL
    end
  end

  it 'returns the base url to connect' do
    @cic.should eql Cic::BASE_URL
  end
end
