require File.dirname(__FILE__) + '/../../../spec_helper'

describe "AccountManagement::Request" do
  before(:each) do
    @client = AccountManagement::Request.new
  end

  describe "requests" do
    it "should call submit_request and return it's result" do
      response = AccountManagement::Response.new({:account_id => 'b1adc7af83a302be94891cf17014c98a'})
      options = mock
      @client.should_receive(:submit_request).with(:create_account, options).and_return(response)
      @client.create_account(options).should == response
    end
  end

  it "should prepare request data from request_type and options" do
    options = { :merchant_id => 'one', :account_id => 'account id' }
    request_type = :some_type
    result = @client.send(:prepare_request_data, request_type, options)
    result.should match %r{<REQUEST type="#{request_type}">}

    options.each do |k,v| 
      key = OptionTranslator.to_server(k)
      result.should match %r{<#{key}>#{v}</#{key}>}
    end
  end
  
  it "should prepare transaction attributes" do
    id = 10
    result = @client.send(:prepare_request_data, 'any', {}, {:id => id} )
    result.should match %r{<Transaction id="#{id}".?>}
  end
  
  it "should parse input XML to MPIResponse and convert keys to client format" do
    response = <<-RESPONSE
    <REQUEST type=\"update_account\">
        <Transaction>
            <AccountId>9933fab999fd3fd0651df2c73bd6f12e</AccountId>
            <Id>231</Id>
        </Transaction>
    </REQUEST>
    RESPONSE

    result = @client.send(:parse_response, response)

    result.data.should == {
      :account_id     => '9933fab999fd3fd0651df2c73bd6f12e',
      :merchant_id    => '231'
    }
    result.should be_success
  end

  it "should return not success response, when response data contain Error field." do
    response = <<-RESPONSE
    <REQUEST type=\"update_account\">
      <Error code="C2">Format XML-request is not valid</Error>
    </REQUEST>
    RESPONSE

    result = @client.send(:parse_response, response)
    result.should_not be_success
    result.error_message.should == 'Format XML-request is not valid'
    result.error_code.should    == 'C2'
    result.errors.should == {:base => 'Format XML-request is not valid'}
  end

  it "should set logger" do
    connection, logger = mock, mock
    Network::Connection.stub(:new).and_return(connection)
    MPIClient.should_receive(:logger).twice.and_return(logger)
    connection.should_receive(:logger=).with(logger)
    connection.should_receive(:request_filter=)
    connection.should_receive(:response_filter=)
    AccountManagement::Request.new
  end
end
