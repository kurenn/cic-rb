require 'spec_helper'

def mock_request(url, body)
  stub_request(:get, url).to_return(headers: { "Content-Type" => 'application/json' }, body: body.to_json)
end
