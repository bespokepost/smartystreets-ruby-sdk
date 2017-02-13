module InternationalStreet
  class Components
    FIELDS = %w(
      country_iso_3
      super_administrative_area
      administrative_area
      sub_administrative_area
      dependent_locality
      dependent_locality_namea
      double_dependent_locality
      locality
      postal_code
      postal_code_short
      postal_code_extra
      premise
      premise_extra
      premise_number
      premise_type
      thoroughfare
      thoroughfare_predirection
      thoroughfare_postdirection
      thoroughfare_name
      thoroughfare_trailing_type
      thoroughfare_type
      dependent_thoroughfare
      dependent_thoroughfare_predirection
      dependent_thoroughfare_postdirection
      dependent_thoroughfare_name
      dependent_thoroughfare_trailing_type
      dependent_thoroughfare_type
      building
      building_leading_type
      building_name
      building_trailing_type
      sub_building_type
      sub_building_number
      sub_building_name
      sub_building
      post_box
      post_box_type
      post_box_number
    ).freeze

    attr_reader *FIELDS.map(&:to_sym)

    def initialize(obj)
      FIELDS.each do |field|
        instance_variable_set("@#{field}", obj[field])
      end
    end
  end
end
