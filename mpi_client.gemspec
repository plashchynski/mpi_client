Gem::Specification.new do |s|
  s.name         = 'mpi_client'
  s.version      = '0.0.1'
  s.authors      = ['Dmitry Plashchynski', 'Evgeniy Sugakov']
  s.homepage     = 'http://github.com/plashchynski/mpi_client/'
  s.summary      = 'MPI client library'
  s.email        = 'plashchynski@gmail.com'
  s.require_path = "lib"
  s.has_rdoc     = false
  s.files        = ["lib/mpi_client.rb"]
  s.test_files   = ["spec/mpi_client_spec.rb"]
  s.rubygems_version = "1.3.0"
  s.add_dependency("nokogiri", [">= 1.3.2"])
  s.add_dependency("alovak-network", [">= 1.1.2"])
end
