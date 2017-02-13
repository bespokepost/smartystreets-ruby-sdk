module InternationalStreet
  class Analysis
    attr_reader :verification_status, :address_precision, :max_address_precision

    def initialize(obj)
      @verification_status = obj['verification_status']
      @address_precision = obj['address_precision']
      @max_address_precision = obj['max_address_precision']
    end
  end
end
