class MPIResponse
  attr_accessor :data
  attr_accessor :error_code
  attr_accessor :error_message

  def initialize(data = nil)
    self.data = data
  end

  def success?
    error_code.nil? && error_message.nil?
  end
end
