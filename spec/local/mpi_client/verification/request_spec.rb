require File.dirname(__FILE__) + '/../../../spec_helper'

describe "Verification::Request" do
  before(:each) do
    options = {
      :account_id       => '100',
      :amount           => '100',
      :card_number      => '42000000000000',
      :description      => 'Test purchase',
      :display_amount   => 'USD 1.00',
      :currency         => '840',
      :exp_year         => '2016',
      :exp_month        => '02',
      :termination_url  => 'http://term.com',
    }

    @transaction_id = '123456'

    @request = Verification::Request.new(options, @transaction_id)
  end

  describe "process" do
    it "should return MPIResponse" do
      @request.should_receive(:build_xml).ordered
      @request.should_receive(:post).ordered
      Verification::Response.should_receive(:parse)
      @request.process
    end

    it "should invoke MPIResponse parse with xml response" do
      @request.stub!(:build_xml => 'builded xml')
      @request.should_receive(:post).with('builded xml').and_return('xml response')
      Verification::Response.should_receive(:parse).with("xml response")
      @request.process
    end
  end

  describe "post" do
    it "should post data with connection" do
      connection = mock
      MPIClient.stub!(:server_url => 'http://mpi-url/')
      @request.stub!(:connection).and_return(connection)
      connection.should_receive(:post).with('xml request')
      @request.send(:post, 'xml request')
    end
  end

  describe "xml" do
    it "should contain transaction id" do
      xml = @request.send(:build_xml)
      xml.should match /Transaction id="#{@transaction_id}"/
    end

    it "should contain request type" do
      xml = @request.send(:build_xml)
      xml.should match /REQUEST type="vereq"/
    end

    it "should contain mapped options" do
      xml = @request.send(:build_xml)
      %w(AccountId Amount CardNumber Description DisplayAmount CurrencyCode ExpY ExpM URL).each do |item|
        xml.should match %r{<#{item}>.+</#{item}>}
      end
    end
  end
end
