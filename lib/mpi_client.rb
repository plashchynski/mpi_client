require 'rubygems'
require 'network'
require 'nokogiri'
require 'active_support/core_ext/module/attribute_accessors'

module MPIClient
  mattr_accessor :server_url
  mattr_accessor :logger
  self.server_url = 'http://mpi.server.com/'

  autoload :OptionTranslator,   'mpi_client/option_translator'
  autoload :ErrorParser,        'mpi_client/error_parser'
  autoload :BaseRequest,        'mpi_client/base_request'
  autoload :Verification,       'mpi_client/verification'
  autoload :AccountManagement,  'mpi_client/account_management'
end
