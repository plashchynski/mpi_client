module MPIClient
  class BaseRequest
    FILTERED_FIELDS = []
    attr_reader :connection

    def initialize
      @connection = Network::Connection.new(MPIClient.server_url)
      @connection.logger = MPIClient.logger if MPIClient.logger
      set_logger_filters
    end

  private
    def set_logger_filters
      filter = lambda {|data| filter_xml_data(data, FILTERED_FIELDS) }
      @connection.request_filter = @connection.response_filter = filter
    end

    def filter_xml_data(request, *filtered_params)
      filter_data(request, filtered_params) do |data, param|
        data.gsub!(%r{<(#{param})>(.*?)</#{param}>}, '<\1>[FILTERED]</\1>')
      end
    end

    def filter_data(data, *filtered_params)
      data = data.dup
      filtered_params.flatten.each do |param|
        yield(data, param)
      end
      data
    end
  end
end
