require File.dirname(__FILE__) + '/../../spec_helper'


describe "BaseRequest" do
  describe "filter_xml_data" do
    it "should replace fields in XML" do
      request = BaseRequest.new
      xml = <<-XML
        <xml>
          <user>secret</user>
          <password>password</password>
          <data>not secret</data>
        </xml>
      XML

      xml = request.send(:filter_xml_data, xml, :user, :password)


      xml.should =~ /<user>\[FILTERED\]<\/user>/
      xml.should =~ /<password>\[FILTERED\]<\/password>/
      xml.should =~ /<data>not secret<\/data>/
    end
  end
end
