module MPIClient
  module ErrorParser
    def self.get_base_message(error_message, error_code)
      error_message[/^(.*?)(?:\ \(|$)/, 1] unless error_code == 'C5'
    end

    def self.parse(error_message, error_code)
      result = Hash.new
      base_message = get_base_message(error_message, error_code)
      result[:base] = base_message if base_message
      error_message.scan(/(?:\ |\()([A-Z].*?)\./) do |error_field, second_field|
        field_name = error_field[/^.*\ \[(.*)\].*$/, 1]
        error_str  = error_field.gsub(/\ \[.*\]/,'')
        result[OptionTranslator.to_client(field_name.to_sym)] = error_str
      end
      result
    end
  end
end
