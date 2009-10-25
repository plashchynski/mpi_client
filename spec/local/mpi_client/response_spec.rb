require File.dirname(__FILE__) + '/../../spec_helper'

describe "Response" do
  it "should contain data" do
    response_data = {:a => 1, :b => 2}
    Response.new(response_data).data.should == response_data
  end

  describe "automatic accessors" do
    it "should return 'data' hash value" do
      response = Response.new({:status => 'Y'})
      response.status.should == response.data[:status]
    end

    it "should return nil if there is no value in 'data' hash" do
      response = Response.new()
      response.status.should be_nil
    end
  end

  describe "success?" do
    it "should be true if error code and error message is nil" do
      Response.new.should be_success
    end

    it "should be false if error code or error message not nil" do
      response = Response.new(:error_code => "C3", :error_message => 'Somthing went wrong.')
      response.should_not be_success
    end
  end
end
