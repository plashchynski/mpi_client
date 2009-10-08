class MPIResponse
  attr_reader   :data
  #attr_accessor :error_code
  #attr_accessor :error_message

  def initialize(data = {})
    @data = data
  end

  def success?
    error_code.nil? && error_message.nil?
  end

  def method_missing(method)
    data[method]
  end
end
