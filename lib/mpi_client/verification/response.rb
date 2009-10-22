module MPI
  module Verification
    class Response
      attr_reader :xml, :error_code, :error_message, :status, :url

      def initialize(xml)
        @xml = xml
      end

      def successful?
        !(error_message || error_code)
      end

      def parse
        doc = Nokogiri::XML(xml)

        unless (error = doc.xpath("//Error")).empty?
          @error_message = error.text
          @error_code    = error.attr('code')
        else
          @status = doc.xpath("//Transaction").attr('status')
          @url = doc.xpath("//Transaction/URL").text
        end
      end

      def self.parse(xml)
        response = self.new(xml)
      end
    end
  end
end
