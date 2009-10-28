require File.dirname(__FILE__) + '/../../spec_helper'

describe "ErrorParser" do
  it "should parse error string to array" do
    error_message = 'Wrong data format (Mandatory parameter [URL] is empty. Mandatory parameter [Id] is empty. Mandatory parameter [AcquirerBIN] is empty.)'
    expected_result = {
      :base         => 'Wrong data format', 
      :site_url     => 'Mandatory parameter is empty',
      :merchant_id  => 'Mandatory parameter is empty',
      :acquirer_bin => 'Mandatory parameter is empty'
    }
    ErrorParser.parse(error_message).should == expected_result
  end
end
