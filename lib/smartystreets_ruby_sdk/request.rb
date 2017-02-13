class Request
  attr_accessor :parameters, :payload, :url_prefix, :referer, :headers

  def initialize
    @parameters = {}
    @payload = nil
    @url_prefix = nil
    @referer = nil
    @headers = {}
  end

  def has_payload?
    !payload.nil?
  end

  def add_parameters(params)
    params.each do |key, val|
      @parameters[key] = URI.escape(val) unless val.nil?
    end
  end
end