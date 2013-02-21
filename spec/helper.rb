require 'spec_helper'

def mock_request(url, body, params = {}, method = :get)
  stub = stub_request(method, url)
  stub = stub.with(query: params) unless params.length.zero?
  stub = stub.to_return(headers: { "Content-Type" => 'application/json' }, body: body.to_json)
  stub
end
