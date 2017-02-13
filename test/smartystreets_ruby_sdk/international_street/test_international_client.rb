require 'minitest/autorun'
require './lib/smartystreets_ruby_sdk/exceptions'
require './test/mocks/request_capturing_sender'
require './test/mocks/fake_serializer'
require './test/mocks/fake_deserializer'
require './test/mocks/mock_sender'
require './test/mocks/mock_exception_sender'
require './lib/smartystreets_ruby_sdk/international_street'

class TestInternationalClient < Minitest::Test
  Lookup = InternationalStreet::Lookup
  Candidate = InternationalStreet::Candidate
  Client = InternationalStreet::Client

  def test_country_code_assigned_to_country_field
    country_code = 'MX'
    lookup = Lookup.new(country_code)

    assert_equal(country_code, lookup.country)
  end

  def test_successfully_sends_lookup
    lookup = new_lookup
    sender = RequestCapturingSender.new
    client = Client.new(sender, FakeSerializer.new(nil))
    client.send_lookup(lookup)
    expected_payload = { 'country' => lookup.country }
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

  def test_raises_exception_when_response_has_error
    exception = BadCredentialsError
    client = Client.new(MockExceptionSender.new(exception), FakeSerializer.new(nil))

    assert_raises exception do
      client.send_lookup(new_lookup)
    end
  end

  private

  def new_lookup(*args)
    Lookup.new('CA', *args)
  end
end
