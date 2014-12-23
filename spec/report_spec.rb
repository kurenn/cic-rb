require 'spec_helper'
require 'cic/report'
require 'cic/errors'
require 'helper'
require 'active_support/core_ext/object/to_query'

describe Cic::Report do

  URL = "http://api.nl.cic.mx/0/nl/reports.json"

  before(:each) do
    @attr =  { "content" => "*ACCIDENTE* En Carretera a Laredo y Jos\u00E9 Clemente Orozco ESC #mtyfollow 11:32 via @escuadronvial", "state" => "read", "created_at" => "2013-02-20T11:33:37-06:00", "updated_at" => "2013-02-20T11:35:20-06:00", "lat" => "25.79174804389648", "lng" => "-100.28132557868958", "is_public" => true, "votes" => 0, "stars" => 0.0, "address_detail" => {
      "formatted_address" => "Jose Clemente Orozco, Sin Nombre de Colonia 17, General Escobedo, NL, M\u00E9xico", "zipcode" => nil, "county" => {
        "long_name" => "General Escobedo", "short_name" => "Gral Escobedo"
      }, "state" => {
        "long_name" => "Nuevo Le\u00F3n", "short_name" => "NL"
      }, "neighborhood" => {
        "long_name" => "Sin Nombre de Colonia 17", "short_name" => "Sin Nombre de Col 17"
      }
    }, "group" => "Vialidad y Transito (SS)", "categories" => ["ACCIDENTE"]
  }
  end

  subject { Cic::Report.new(@attr) }
  let(:report) { Cic::Report.new(@attr) }

  it { should respond_to(:attributes) } 
  it { should respond_to(:raw_attributes) } 

  describe '#find' do

    before(:each) do
      @find_attr = @attr.merge({ "ticket" => "#A2S3" })
    end
    context 'when response is success' do
      it 'returns the record specified by the ticket id' do
        mock_request(URL, { reports: [@find_attr] })
        Cic::Report.find(@find_attr['ticket']).ticket.should eql @find_attr['ticket']
      end

      it 'returns nil when no record found' do
        mock_request(URL, { reports: [@find_attr] })
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

  describe '#where' do
    it 'returns reports by group id' do
      options = { for_group: 142 }
      mock_request(URL, { reports: [@attr, @attr] }, options)
      Cic::Report.where(options).should_not be_empty
    end

    it 'returns reports by category id' do
      options = { for_category: 142 }
      mock_request(URL, { reports: [@attr, @attr] }, options)
      Cic::Report.where(options).should_not be_empty
    end

    it 'returns reports by until date' do
      options = { :until => "2012-01-01" }
      mock_request(URL, { reports: [@attr, @attr] }, options)
      Cic::Report.where(:until => "2012-01-01").should_not be_empty #YYYY-MM-DD
    end

    it 'returns reports by group id and category id' do
      options = { for_category: 417, for_group: 134 }
      mock_request(URL, { reports: [@attr, @attr] }, options)
      Cic::Report.where(options).should_not be_empty
    end
  end

  describe '#save' do
    before(:each) do
      @params = {
        content: 'Lorem'
      }
      @report = Cic::Report.new(@attr)
      stub_request(:post, "http://api.nl.cic.mx/0/nl/reports.json").
         with(:body => "content=*ACCIDENTE*%20En%20Carretera%20a%20Laredo%20y%20Jos%C3%A9%20Clemente%20Orozco%20ESC%20%23mtyfollow%2011%3A32%20via%20%40escuadronvial&state=read&created_at=2013-02-20T11%3A33%3A37-06%3A00&updated_at=2013-02-20T11%3A35%3A20-06%3A00&lat=25.79174804389648&lng=-100.28132557868958&is_public=true&votes=0&stars=0.0&address_detail[formatted_address]=Jose%20Clemente%20Orozco%2C%20Sin%20Nombre%20de%20Colonia%2017%2C%20General%20Escobedo%2C%20NL%2C%20M%C3%A9xico&address_detail[zipcode]=&address_detail[county][long_name]=General%20Escobedo&address_detail[county][short_name]=Gral%20Escobedo&address_detail[state][long_name]=Nuevo%20Le%C3%B3n&address_detail[state][short_name]=NL&address_detail[neighborhood][long_name]=Sin%20Nombre%20de%20Colonia%2017&address_detail[neighborhood][short_name]=Sin%20Nombre%20de%20Col%2017&group=Vialidad%20y%20Transito%20(SS)&categories[]=ACCIDENTE",
              :headers => {'Accept'=>'*/*', 'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3', 'User-Agent'=>'Ruby'}).
         to_return(:status => 200, :body => {reports: { ticket: "#123" }}.to_json, :headers => {"Content-Type" => 'application/json'})
    end

    it 'returns true if report was saved successfully' do
      expect(report.save).to eql(true)
    end

    it 'returns a ticket number on the response' do
      expect{ @report.save }.to change{ @report.ticket_id }.from(nil).to("#123")
    end


  end
end
