require_relative '../json_able'

module InternationalStreet
  class Lookup < JSONAble
    attr_accessor :country, :address1, :address2, :address3, :address4, :organization, :locality,
                   :administrative_area, :postal_code, :geocode, :language, :freeform, :input_id, :result

    def initialize(country, address1=nil, address2=nil, address3=nil, address4=nil, organization=nil, locality=nil,
                   administrative_area=nil, postal_code=nil, geocode=nil, language=nil, freeform=nil, input_id=nil)
      @country = country
      @address1 = address1
      @address2 = address2
      @address3 = address3
      @address4 = address4
      @organization = organization
      @locality = locality
      @administrative_area = administrative_area
      @postal_code = postal_code
      @geocode = geocode
      @language = language
      @freeform = freeform
      @input_id = input_id
      @result = []
    end

    def to_hash
      {
        'country' => @country,
        'address1' => @address1,
        'address2' => @address2,
        'address3' => @address3,
        'address4' => @address4,
        'organization' => @organization,
        'locality' => @locality,
        'administrative_area' => @administrative_area,
        'postal_code' => @postal_code,
        'geocode' => @geocode,
        'language' => @language,
        'freeform' => @freeform,
        'input_id' => @input_id,
      }
    end
  end
end
