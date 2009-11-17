Gem::Specification.new do |s|
  s.name         = 'mpi_client'
  s.version      = '0.0.9'
  s.authors      = ['Dmitry Plashchynski', 'Evgeniy Sugakov']
  s.homepage     = 'http://github.com/plashchynski/mpi_client/'
  s.summary      = 'MPI client library'
  s.email        = 'plashchynski@gmail.com'
  s.require_path = "lib"
  s.has_rdoc     = false
  s.files        =  ["lib/mpi_client/option_translator.rb", "lib/mpi_client/base_request.rb", "lib/mpi_client/account_management.rb", "lib/mpi_client/account_management/request.rb", "lib/mpi_client/account_management/response.rb", "lib/mpi_client/error_parser.rb", "lib/mpi_client/verification/request.rb", "lib/mpi_client/verification/response.rb", "lib/mpi_client/verification.rb", "lib/mpi_client.rb"]
  s.rubygems_version = "1.3.0"
  s.add_dependency("nokogiri", [">= 1.3.2"])
  s.add_dependency("alovak-network", [">= 1.1.2"])
  s.add_dependency("activesupport", [">= 2.3.2"])
end
