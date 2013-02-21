require 'spec_helper'
require 'cic/report'
require 'cic/errors'
require 'helper'

describe Cic::Report do

  URL = "http://api.nl.cic.mx/0/nl/reports.json"

  before(:each) do
    @attr =  {"ticket"=>"#7LVB", "content"=>"*ACCIDENTE* En Carretera a Laredo y Jos\u00E9 Clemente Orozco ESC #mtyfollow 11:32 via @escuadronvial", "state"=>"read", "created_at"=>"2013-02-20T11:33:37-06:00", "updated_at"=>"2013-02-20T11:35:20-06:00", "lat"=>"25.79174804389648", "lng"=>"-100.28132557868958", "is_public"=>true, "votes"=>0, "stars"=>0.0, "address_detail"=>{"formatted_address"=>"Jose Clemente Orozco, Sin Nombre de Colonia 17, General Escobedo, NL, M\u00E9xico", "zipcode"=>nil, "county"=>{"long_name"=>"General Escobedo", "short_name"=>"Gral Escobedo"}, "state"=>{"long_name"=>"Nuevo Le\u00F3n", "short_name"=>"NL"}, "neighborhood"=>{"long_name"=>"Sin Nombre de Colonia 17", "short_name"=>"Sin Nombre de Col 17"}}, "group"=>"Vialidad y Transito (SS)", "categories"=>["ACCIDENTE"]}
  end

  subject { Cic::Report.new(@attr) }
  let(:report) { Cic::Report.new(@attr) }

  it { should respond_to(:attributes) } 
  it { should respond_to(:raw_attributes) } 

  describe '#find' do

    context 'when response is success' do
      it 'returns the record specified by the ticket id' do
        mock_request(URL, { reports: [@attr] })
        Cic::Report.find(@attr['ticket']).ticket.should eql @attr['ticket']
      end

      it 'returns nil when no record found' do
        mock_request(URL, { reports: [@attr] })
        Cic::Report.find('#1234').should be_nil
      end
    end

    context 'when response fails' do
      it 'raises a server exception' do
        stub_request(:get, URL).to_return(status: 500)
        lambda { Cic::Report.find('#1234')}.should raise_exception(Cic::Exception::ServerError)
      end

      it 'raises a client exception' do
        stub_request(:get, URL).to_return(status: 404)
        lambda { Cic::Report.find('#1234') }.should raise_exception(Cic::Exception::ClientError)
      end
    end
  end

  describe '#all' do
    
    context 'when response is success' do
      it 'returns an empty array when no reports' do
        mock_request(URL, { reports: [] })
        Cic::Report.all.should be_empty
      end
      
      it 'returns an array of reports' do
        mock_request(URL, { reports: [@attr] })
        Cic::Report.all.first.should be_instance_of(Cic::Report)
      end
    end

    
    context 'when response fails' do
      it 'raises a server exception' do
        stub_request(:get, URL).to_return(status: 500)
        lambda { Cic::Report.all }.should raise_exception(Cic::Exception::ServerError)
      end

      it 'raises a client exception' do
        stub_request(:get, URL).to_return(status: 404)
        lambda { Cic::Report.all }.should raise_exception(Cic::Exception::ClientError)
      end
    end
  end
end
