require File.dirname(__FILE__) + '/../lib/mpi_client.rb'

describe "OptionTranslator" do
  it "should translate options" do
    { :id           => :Id,
      :site_name    => :Name,
      :url          => :URL,
      :cert_subject => :IP,
      :acquirer_bin => :AcquirerBIN,
      :country_code => :CountryCode,
      :password     => :Password,
      :pub_cert     => :PublicCertificate,
      :priv_key     => :PrivateKey,
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