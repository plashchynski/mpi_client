require File.dirname(__FILE__) + '/../../../spec_helper'

describe "Verification::Response" do
  it "should return Response instance" do
    Verification::Response.parse('').should be_an_instance_of(Verification::Response)
  end

  before(:each) do
    @response = Verification::Response.new('')
  end
  
  context 'xml contain sucessful response with status "N"' do
    before(:each) do
      @response.stub!(:xml => <<-XML)
        <?xml version="1.0" encoding="UTF-8"?>
        <Response type="vereq">
            <Transaction id="33557" status="N">
            </Transaction>
        </Response>
        XML
      @response.parse
    end

    it "should not be successful if xml does not contain Error item" do
      @response.should_not be_successful
    end
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

  context 'xml contains unexpected response' do
    before(:each) do
      @response.stub!(:xml => <<-XML)
          <xml>hello</xml>
        XML
      @response.parse
    end

    it "should not be successful if xml contains Error item" do
      @response.should_not be_successful
    end

    it "should contain error message and empty error code" do
      @response.error_message.should == 'Unknown response was received from MPI'
      @response.error_code.should == ''
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

    it "should not be successful" do
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

