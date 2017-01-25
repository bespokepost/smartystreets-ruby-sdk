require_relative '../core_client_builder'
require_relative 'client'

module USAutocomplete
  class ClientBuilder < CoreClientBuilder
    def initialize(signer)
      super(signer)
      @url_prefix = 'https://us-autocomplete.api.smartystreets.com/suggest'
    end

    def build
      Client.new(build_sender, @serializer)
    end
  end
end