require 'spec_helper'
require 'cic/category'
require 'cic/errors'
require 'helper'

describe Cic::Category do

  URL = "http://api.nl.cic.mx/0/nl/categories.json"

  before(:each) do
    @attr = {
      "id" => 407,
      "name" => "ACCIDENTE",
      "metadata" => false,
      "type" => "blackbox",
      "group" => ["Servicios Publicos (CS)"]
    } 
  end

  subject { Cic::Category.new(@attr) }
  let(:category) { Cic::Category.new(@attr) }

  it { should respond_to(:attributes) } 
  it { should respond_to(:id) }
  it { should respond_to(:type) }
  it { should respond_to(:raw_attributes) } 

  describe '#all' do
    
    context 'when response is success' do
      it 'returns an empty array when no reports' do
        mock_request(URL, { categories: [] })
        Cic::Category.all.should be_empty
      end
      
      it 'returns an array of reports' do
        mock_request(URL, { categories: [@attr] })
        Cic::Category.all.first.should be_instance_of(Cic::Category)
      end
    end

    
    context 'when response fails' do
      it 'raises a server exception' do
        stub_request(:get, URL).to_return(status: 500)
        lambda { Cic::Category.all }.should raise_exception(Cic::Exception::ServerError)
      end

      it 'raises a client exception' do
        stub_request(:get, URL).to_return(status: 404)
        lambda { Cic::Category.all }.should raise_exception(Cic::Exception::ClientError)
      end
    end
  end

  describe '#id' do
    it 'returns the id from the category' do
      category.id.should eql 407 
    end
  end

  describe '#type' do
    it 'returns the type from the category' do
      category.type.should eql "blackbox"
    end
  end
end
