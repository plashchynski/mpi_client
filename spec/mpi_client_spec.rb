require File.dirname(__FILE__) + '/../lib/mpi_client.rb'

describe "MPIClient" do
  before(:each) do
    @client = MPIClient.new('http://127.0.0.1/3ds/')
    @options = {
      :id           => 'some id',
      :site_name    => 'site name',
      :url          => 'http://siteurl/',
      :cert_subject => 'subject',
      :acquirer_bin => '3213',
      :country_code => '432',
      :password     => 'qwerty',
      :pub_cert     => 'e2ie01i20ei12',
      :priv_key     => '334123e123e23',
      :directory_server_url => 'http://www.visa.com/ds/',
      :brand        => '1',
      :response_url => 'http://www.response.com/gk/',
      :client_url   => 'http://www.client.com/',
      :term_url     => 'http://www.term.com/',
    }
  end

  describe "create_account" do
    it "should submit create_account request to server" do
      account_id = 'b1adc7af83a302be94891cf17014c98a'
      @client.should_receive(:submit_request).with(:create_account, @options).and_return(MPIResponse.new({:account_id => account_id}))
      @client.create_account(@options).data.should == {:account_id => account_id}
    end
  end

  describe "account_info" do
    it "should submit get_account_info request to server" do
      account_id = 'b1adc7af83a302be94891cf17014c98a'
      @client.should_receive(:submit_request).with(:get_account_info, {:account_id => account_id}).and_return(MPIResponse.new(@options))
      @client.account_info(account_id).data.should == @options
    end
  end

  describe "update_account" do
    it "should submit update_account request to server" do
      account_id = 'b1adc7af83a302be94891cf17014c98a'
      @client.should_receive(:submit_request).with(:update_account, @options.merge({:account_id => account_id})).and_return(MPIResponse.new({:account_id => account_id}))
      @client.update_account(account_id, @options).data.should == {:account_id => account_id}
    end
  end

  describe "delete_account" do
    it "should submit delete_account request to server" do
      account_id = 'b1adc7af83a302be94891cf17014c98a'
      @client.should_receive(:submit_request).with(:delete_account, {:account_id => account_id}).and_return(MPIResponse.new({:account_id => account_id}))
      @client.delete_account(account_id).data.should == {:account_id => account_id}
    end
  end
  
  describe "enrolled" do
    it "should submit enrolled request to server" do
      account_id  = '0'*32
      card_number = '4012001037141112'
      @client.should_receive(:submit_request).with(:enrolled, {:account_id => account_id, :card_number => card_number}).and_return(MPIResponse.new({:status => 'Y'}))
      @client.enrolled({:account_id => account_id, :card_number=>card_number}).data.should == {:status => 'Y'}
    end
  end

  describe "prepare_request_data" do
    it "should build xml from request_type and options" do
      request_type = :some_type
      result = @client.send(:prepare_request_data, request_type, @options)
      result.should match %r{<REQUEST\ type="#{request_type}">}
      @options.each { |k,v| key = OptionTranslator.to_server(k); result.should match %r{<#{key}>#{v}</#{key}>} }
    end
  end

  describe "parse_response" do
    it "should parse input XML to MPIResponse and convert keys to client format" do
      response = <<-RESPONSE
      <REQUEST type=\"update_account\">
          <Transaction>
              <AccountId>9933fab999fd3fd0651df2c73bd6f12e</AccountId>
              <Id>231</Id>
          </Transaction>
      </REQUEST>
      RESPONSE

      result_data = {
        :account_id     => '9933fab999fd3fd0651df2c73bd6f12e',
        :id             => '231'
      }
      result = @client.send(:parse_response, response)
      result.data.should == result_data

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
    end
  end
end
