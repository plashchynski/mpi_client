module MPIClient
  module AccountManagement
    class Response
      attr_reader   :data

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
  end
end
