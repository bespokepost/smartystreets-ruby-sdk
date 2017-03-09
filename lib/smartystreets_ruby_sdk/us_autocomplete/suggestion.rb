module USAutocomplete
  class Suggestion
    attr_reader :text, :street_line, :city, :state

    def initialize(obj)
      @text = obj['text']
      @street_line = obj['street_line']
      @city = obj['city']
      @state = obj['state']
    end
  end
end