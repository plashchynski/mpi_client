require File.dirname(__FILE__) + '/../spec_helper'

describe "Response" do

  it "should return Response instance" do
    MPI::Response.parse('').should be_an_instance_of(MPI::Response)
  end

  before(:each) do
    @response = MPI::Response.new('')
  end

  context 'xml contain sucessful response' do
    before(:each) do
      @response.stub!(:xml => <<-XML)
        <?xml version="1.0" encoding="UTF-8"?>
        <Response type="vereq">
            <Transaction id="33557" status="Y">
                <URL>http://3ds/client/xxx</URL>
            </Transaction>
        </Response>
        XML
      @response.parse
    end

    it "should be successful if xml does not contain Error item" do
      @response.should be_successful
    end

    it "should have 'Y' status" do
      @response.status.should == 'Y'
    end

    it "should have url" do
      @response.url.should == 'http://3ds/client/xxx'
    end
  end

  context "xml contains Error node" do
    before(:each) do
      @response.stub!(:xml => <<-XML)
        <?xml version="1.0" encoding="UTF-8"?>
        <Response type="create_account">
          <Error code="C5">Wrong data</Error>
        </Response>
        XML
      @response.parse
    end

    it "should not be successful if xml contains Error item" do
      @response.should_not be_successful
    end

    it "should contain error message" do
      @response.error_message.should match /Wrong data/
    end

    it "should contain error code" do
      @response.error_code.should == 'C5'
    end
  end
end

describe "Request" do
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

    @request = MPI::VerificationRequest.new(options, @transaction_id)
  end

  describe "process" do
    it "should return MPIResponse" do
      @request.should_receive(:build_xml).ordered
      @request.should_receive(:post).ordered
      MPI::Response.should_receive(:parse)
      @request.process
    end

    it "should invoke MPIResponse parse with xml response" do
      @request.stub!(:build_xml => 'builded xml')
      @request.should_receive(:post).with('builded xml').and_return('xml response')
      MPI::Response.should_receive(:parse).with("xml response")
      @request.process
    end
  end

  describe "post" do
    it "should post data with connection" do
      MPI.stub!(:server_url => 'http://mpi-url/')
      Network.should_receive(:post).with('http://mpi-url/', 'xml request')

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
