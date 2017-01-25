require 'minitest/autorun'
require './lib/smartystreets_ruby_sdk/exceptions'
require './test/mocks/request_capturing_sender'
require './test/mocks/fake_serializer'
require './test/mocks/fake_deserializer'
require './test/mocks/mock_sender'
require './test/mocks/mock_exception_sender'
require './lib/smartystreets_ruby_sdk/us_autocomplete'

class TestUSAutocompleteClient < Minitest::Test
  Lookup = USAutocomplete::Lookup
  Suggestion = USAutocomplete::Suggestion
  Client = USAutocomplete::Client

  def test_freeform_assigned_to_street_field
    lookup = Lookup.new('123 fake')

    assert_equal('123 fake', lookup.prefix)
  end

  def test_successful_send_lookup
    lookup = new_lookup
    sender = RequestCapturingSender.new
    client = Client.new(sender, FakeSerializer.new(nil))
    client.send_lookup(lookup)
    expected_payload = { 'prefix' => lookup.prefix }
    assert_equal(expected_payload, sender.request.parameters)
  end

  def test_deserialize_called_with_response_body
    response = Response.new('Hello, World!', 0)
    sender = MockSender.new(response)
    deserializer = FakeDeserializer.new(nil)
    client = Client.new(sender, deserializer)
    client.send_lookup(new_lookup)

    assert_equal(response.payload, deserializer.input)
  end

def test_suggestions_in_response
    raw_response = suggestions_response_data
    expected_suggestions = raw_response['suggestions'].map { |suggestion| Suggestion.new(suggestion) }
    sender = MockSender.new(Response.new('[]', 0))
    deserializer = FakeDeserializer.new(raw_response)
    client = Client.new(sender, deserializer)
    lookup = new_lookup
    client.send_lookup(lookup)

    expected_suggestions.each_with_index do |expected_suggestion, i|
      assert_equal(expected_suggestion.street_line, lookup.result[:suggestions][i].street_line)
    end
  end

  def test_raises_exception_when_response_has_error
    exception = BadCredentialsError
    client = Client.new(MockExceptionSender.new(exception), FakeSerializer.new(nil))

    assert_raises exception do
      client.send_lookup(new_lookup)
    end
  end

  private

  def new_lookup
    Lookup.new('123')
  end

  def suggestions_response_data
    {
      'suggestions' => [
        { 'street_line' => '123 Fake St', 'city' => 'Jersey City', 'state' => 'NJ' },
        { 'street_line' => '123 Fake Rd', 'city' => 'New York', 'state' => 'NY' },
        { 'street_line' => '123 Fake Blvd', 'city' => 'Atlanta', 'state' => 'GA' },
      ].each do |suggestion|
        suggestion['text'] = "#{suggestion['street_line']}, #{suggestion['city']} #{suggestion['state']}"
      end
    }
  end
end