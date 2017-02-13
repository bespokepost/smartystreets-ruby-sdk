require_relative '../request'
require_relative 'candidate'

module InternationalStreet
  class Client
    def initialize(sender, serializer)
      @sender = sender
      @serializer = serializer
    end

    def send_lookup(lookup)
      smarty_request = Request.new

      # NOTE: International Street Lookup requests are all GET requests so the payload is set on parameters
      smarty_request.add_parameters(lookup.to_hash)

      response = @sender.send(smarty_request)

      raise response.error if response.error

      raw_response = @serializer.deserialize(response.payload)
      lookup.result = format_response(raw_response)
    end

    private

    # Sample response:
    # [
    #   {
    #     "address1" => "301 Front St W",
    #     "address2" => "Toronto ON M5V 2T6",
    #     "components" => {
    #       "administrative_area" => "ON",
    #       "country_iso_3" => "CAN",
    #       "locality" => "Toronto",
    #       "postal_code" => "M5V 2T6",
    #       postal_code_short" => "M5V 2T6",
    #       "premise" => "301",
    #       "premise_number" => "301",
    #       "thoroughfare" => "Front St W",
    #       "thoroughfare_name" => "Front",
    #       "thoroughfare_trailing_type" => "St"
    #     },
    #     "metadata" => {},
    #     "analysis" => {
    #       "verification_status" => "Verified",
    #       "address_precision" => "Premise",
    #       "max_address_precision" => "DeliveryPoint"
    #     }
    #   }
    # ]
    def format_response(raw_response)
      raw_response.map do |raw_record|
        Candidate.new(raw_record)
      end
    end
  end
end
