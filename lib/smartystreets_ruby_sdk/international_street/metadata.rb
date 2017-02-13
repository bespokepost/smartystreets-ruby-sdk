module InternationalStreet
  class Metadata
    attr_reader :latitude, :longitude, :geocode_precision, :max_geocode_precision

    def initialize(obj)
      @latitude = obj['latitude']
      @longitude = obj['longitude']
      @geocode_precision = obj['geocode_precision']
      @max_geocode_precision = obj['max_geocode_precision']
    end
  end
end
