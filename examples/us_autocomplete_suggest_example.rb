require_relative '../lib/smartystreets_ruby_sdk/static_credentials'
require_relative '../lib/smartystreets_ruby_sdk/us_autocomplete'

class UsAutocompleteSuggestExample
  def run
    auth_id = ENV['SMARTY_AUTH_ID'] # We recommend storing your keys in environment variables
    auth_token = ENV['SMARTY_AUTH_TOKEN']
    credentials = StaticCredentials.new(auth_id, auth_token)
    client = USAutocomplete::ClientBuilder.new(credentials).build
    lookup = USAutocomplete::Lookup.new('350 5th Ave')

    begin
      client.send_lookup(lookup)
    rescue SmartyException => err
      puts err
      return
    end

    result = lookup.result

    if result[:suggestions]
      puts %(Suggestions for "#{lookup.prefix}":)
      result[:suggestions].each do |suggestion|
        puts "\nText: #{suggestion.text}"
        puts "Street Line: #{suggestion.street_line}"
        puts "City: #{suggestion.city}"
        puts "State: #{suggestion.state}"
      end
    else
      puts %(No suggestions for "#{lookup.prefix}")
    end
  end
end

example = UsAutocompleteSuggestExample.new
example.run