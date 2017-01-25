require_relative '../json_able'

module USAutocomplete
  class Lookup < JSONAble
    attr_accessor :prefix, :suggestions, :city_filter, :state_filter, :prefer, :geolocate, :geolocate_precision, :result

    def initialize(prefix, suggestions=nil, city_filter=nil, state_filter=nil, prefer=nil,
        geolocate=nil, geolocate_precision=nil)
      @prefix = prefix
      @suggestions = suggestions
      @city_filter = city_filter
      @state_filter = state_filter
      @prefer = prefer
      @geolocate = geolocate
      @geolocate_precision = geolocate_precision
      @result = []
    end
  end
end