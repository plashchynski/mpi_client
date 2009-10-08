class OptionTranslator
  OPTION_MAP = {
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
    :error        => :Error,
    :card_number  => :CardNumber,
    :status       => :status
  }

  def self.to_client(option)
    OPTION_MAP.invert[option]
  end

  def self.to_server(option)
    OPTION_MAP[option]
  end
end
