require File.dirname(__FILE__) + '/../../spec_helper'

describe "ErrorParser" do
  describe "parse" do
    it "should parse error string to hash" do
      error_message = 'Wrong data format (Mandatory parameter [URL] is empty. Mandatory parameter [Id] is empty. Mandatory parameter [AcquirerBIN] is empty.)'
      expected_result = {
        :base         => 'Wrong data format', 
        :site_url     => 'Mandatory parameter is empty',
        :merchant_id  => 'Mandatory parameter is empty',
        :acquirer_bin => 'Mandatory parameter is empty'
      }
      ErrorParser.should_receive(:get_base_message).and_return(expected_result[:base])
      ErrorParser.parse(error_message, '').should == expected_result
    end
  end

  describe "get_base_message" do
    it "should not write base error if error code is C5" do
      ErrorParser.get_base_message('Wrong data format', 'C5').should be_nil
    end
  end
end
