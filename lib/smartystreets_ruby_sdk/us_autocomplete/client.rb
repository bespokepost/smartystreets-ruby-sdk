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

      # NOTE: US Autocomplete requests are all GET requests so the payload is set on parameters
      smarty_request.add_parameters(lookup.to_hash)

      response = @sender.send(smarty_request)

      raise response.error if response.error

      raw_response = @serializer.deserialize(response.payload)
      lookup.result = format_response(raw_response)
    end

    private

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