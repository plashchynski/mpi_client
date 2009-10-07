require 'rubygems'
require 'network'
require 'nokogiri'

$:.unshift File.dirname(__FILE__)

require 'mpi_client/option_translator'
require 'mpi_client/mpi_response'

class MPIClient
  def initialize(server_url)
    @connection = Network::Connection.new(server_url)
  end

  def create_account(options)
    submit_request(:create_account, options)
  end

  def account_info(account_id)
    submit_request(:get_account_info, {:account_id => account_id})
  end

  def update_account(account_id, options)
    submit_request(:update_account, options.merge({:account_id => account_id}))
  end

  def delete_account(account_id)
    submit_request(:delete_account, {:account_id => account_id})
  end

private
  def submit_request(request_type, options)
    parse_response(@connection.post(prepare_request_data(request_type, options)))
  end

  def prepare_request_data(request_type, options)
    builder = Nokogiri::XML::Builder.new(:encoding => 'UTF-8') do |xml|
      xml.REQUEST(:type => request_type) do |xml|
        xml.Transaction do |xml|
          options.each { |k,v|  xml.send(OptionTranslator.to_server(k), v) }
        end
      end
    end

    builder.to_xml
  end

  def parse_response(response_data)
    response = MPIResponse.new
    doc = Nokogiri::XML(response_data)
    if error = doc.xpath("//Error").first
      response.error_message = error.text
      response.error_code    = error[:code]
    else
      response.data = Hash[*doc.xpath("//Transaction/*").collect{|a| [OptionTranslator.to_client(a.name.to_sym), a.text] }.flatten]
    end
    response
  end
end
