module MPIClient
  module ErrorParser
    def self.parse(error_message)
      result = Hash.new
      result[:base] = error_message[/^(.*)\ \(/, 1]
      error_message.scan(/[\ ,\(]([A-Z].*?)\./).each do |error_field|
        error_field = error_field.to_s
        field_name = error_field[/^.*\ \[(.*)\].*$/, 1]
        error_str  = error_field.gsub(/\ \[.*\]/,'')
        result[OptionTranslator.to_client(field_name.to_sym)] = error_str
      end
      result
    end
  end
end
