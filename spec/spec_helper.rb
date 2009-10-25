require 'rubygems'
require 'ruby-debug'

require File.expand_path(File.dirname(__FILE__) + '/../lib/mpi_client.rb')

include MPIClient

MPIClient.server_url = 'http://192.168.65.11/xml'
