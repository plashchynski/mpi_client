require File.dirname(__FILE__) + '/../lib/mpi_client.rb'

describe "MPIResponse" do
  before(:each) do
    @response = MPIResponse.new
  end

  it "should contain data" do
    response_data = {:a => 1, :b => 2}
    MPIResponse.new(response_data).data.should == response_data
  end

  describe "success?" do
    it "should be true if error code and error message is nil" do
      @response.success?.should be_true  
    end

    it "should be false if error code or error message not nil" do
      @response.error_code = "C3"
      @response.error_message = "Somthing went wrong."
      @response.success?.should be_false
    end
  end
end
