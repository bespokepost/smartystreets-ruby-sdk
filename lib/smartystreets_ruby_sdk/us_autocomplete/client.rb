require_relative '../batch'
require_relative '../request'
require_relative 'suggestion'

module USAutocomplete
  class Client
    def initialize(sender, serializer)
      @sender = sender
      @serializer = serializer
    end

    def send_lookup(lookup)
      smarty_request = Request.new
      smarty_request.parameters.merge!(parameterize_lookup(lookup))

      response = @sender.send(smarty_request)

      raise response.error if response.error

      raw_response = @serializer.deserialize(response.payload)
      lookup.result = format_response(raw_response)
    end

    private

    def parameterize_lookup(lookup)
      params = {}
      %w(prefix suggestions city_filter state_filter prefer geolocate geolocate_precision).each do |field|
        val = lookup.send(field)
        next if val.nil?

        params[field] = URI.escape(val)
      end
      params
    end

    def format_response(raw_response)
      suggestions = if raw_response.nil?
                      []
                    else
                      raw_response['suggestions'].map { |suggestion| Suggestion.new(suggestion) }
                    end
      { suggestions: suggestions }
    end
  end
end