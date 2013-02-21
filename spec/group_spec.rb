require 'spec_helper'
require 'cic/group'
require 'cic/errors'
require 'helper'

describe Cic::Group do

  URL = "http://api.nl.cic.mx/0/nl/groups.json"

  before(:each) do
    @attr = {
      "id" => 142,
       "name" => "Asesorias Generales",
       "categories" => [
         "FALTA ELECTRICIDAD",
         424
       ]
    }
  end

  subject { Cic::Group.new(@attr) }
  let(:group) { Cic::Group.new(@attr) }

  it { should respond_to(:attributes) } 
  it { should respond_to(:raw_attributes) } 
  it { should respond_to(:id) } 

  describe '#all' do

    context 'when response is success' do
      it 'returns an empty array when no reports' do
        mock_request(URL, { groups: [] })
        Cic::Group.all.should be_empty
      end
      
      it 'returns an array of reports' do
        mock_request(URL, { groups: [@attr] })
        Cic::Group.all.first.should be_instance_of(Cic::Group)
      end
    end

    
    context 'when response fails' do
      it 'raises a server exception' do
        stub_request(:get, URL).to_return(status: 500)
        lambda { Cic::Group.all }.should raise_exception(Cic::Exception::ServerError)
      end

      it 'raises a client exception' do
        stub_request(:get, URL).to_return(status: 404)
        lambda { Cic::Group.all }.should raise_exception(Cic::Exception::ClientError)
      end
    end
  end
end
