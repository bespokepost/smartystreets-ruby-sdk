require_relative 'components'
require_relative 'metadata'
require_relative 'analysis'

module InternationalStreet
  class Candidate
    FIELDS = %w(
      input_id
      organization
      address1
      address2
      address3
      address4
      address5
      address6
      address7
      address8
      address9
      address10
      address11
      address12
    ).freeze

    attr_reader *FIELDS
    attr_reader :components, :metadata, :analysis

    def initialize(obj)
      FIELDS.each do |field|
        instance_variable_set("@#{field}", obj[field])
      end

      @components = Components.new(obj.fetch('components', {}))
      @metadata = Metadata.new(obj.fetch('metadata', {}))
      @analysis = Analysis.new(obj.fetch('analysis', {}))
    end
  end
end
