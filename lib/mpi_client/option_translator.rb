class OptionTranslator
    Options_mathing = {
      :id           => :Id,
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
      :account_id   => :AccountId,
      :error        => :Error
    }
  def self.to_client(option)
    Options_mathing.invert[option]
  end

  def self.to_server(option)
    Options_mathing[option]
  end
end
