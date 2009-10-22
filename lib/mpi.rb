module MPI
  mattr_accessor :server_url
  self.server_url = 'http://mpi.server.com/'

  autoload :Verification, 'mpi/verification'
end
