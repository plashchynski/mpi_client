require File.dirname(__FILE__) + '/../../spec_helper'

describe "OptionTranslator" do
  it "should translate options" do
    { :merchant_id  => :Id,
      :site_name    => :Name,
      :site_url     => :URL,
      :certificate_subject => :IP,
      :acquirer_bin => :AcquirerBIN,
      :country_code => :CountryCode,
      :password     => :Password,
      :certificate  => :PublicCertificate,
      :private_key  => :PrivateKey,
      :directory_server_url => :DirectoryServerURL,
      :brand        => :CardType,
      :response_url => :ResponseURL,
      :client_url   => :ClientURL,
      :term_url     => :TermURL,
      :account_id   => :AccountId
    }.each do |client_option, server_option|
      OptionTranslator.to_client(server_option).should == client_option
      OptionTranslator.to_server(client_option).should == server_option
    end
  end
end
