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
end