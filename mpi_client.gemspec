Gem::Specification.new do |s|
  s.name         = 'mpi_client'
  s.version      = '0.0.2'
  s.authors      = ['Dmitry Plashchynski', 'Evgeniy Sugakov']
  s.homepage     = 'http://github.com/plashchynski/mpi_client/'
  s.summary      = 'MPI client library'
  s.email        = 'plashchynski@gmail.com'
  s.require_path = "lib"
  s.has_rdoc     = false
  s.files        =  ["lib/mpi_client/mpi_response.rb", "lib/mpi_client/option_translator.rb", "lib/mpi_client.rb", "remote_spec/mpi_client_spec.rb", "spec/mpi_client_spec.rb", "spec/mpi_response_spec.rb", "spec/option_translator_spec.rb"]
  s.rubygems_version = "1.3.0"
  s.add_dependency("nokogiri", [">= 1.3.2"])
  s.add_dependency("alovak-network", [">= 1.1.2"])
  s.add_dependency("activesupport", [">= 2.3.2"])
end
