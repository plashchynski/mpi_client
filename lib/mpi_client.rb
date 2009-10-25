require 'rubygems'
require 'network'
require 'nokogiri'
require 'active_support/core_ext/module/attribute_accessors'

module MPIClient
  mattr_accessor :server_url
  self.server_url = 'http://mpi.server.com/'

  autoload :OptionTranslator,   'mpi_client/option_translator'
  autoload :Request,            'mpi_client/request'
  autoload :Response,           'mpi_client/response'
  autoload :Verification,       'mpi_client/verification'
end
