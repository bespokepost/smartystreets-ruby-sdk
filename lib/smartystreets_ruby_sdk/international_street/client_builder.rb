require_relative '../core_client_builder'
require_relative 'client'

module InternationalStreet
  class ClientBuilder < CoreClientBuilder
    def initialize(signer)
      super(signer)
      @url_prefix = 'https://international-street.api.smartystreets.com/verify'
    end

    def build
      Client.new(build_sender, @serializer)
    end
  end
end
