require_relative '../lib/smartystreets_ruby_sdk/static_credentials'
require_relative '../lib/smartystreets_ruby_sdk/international_street'

class InternationalStreetLookupExample
  def run
    auth_id = ENV['SMARTY_AUTH_ID']
    auth_token = ENV['SMARTY_AUTH_TOKEN']
    credentials = StaticCredentials.new(auth_id, auth_token)

    client = InternationalStreet::ClientBuilder.new(credentials).build

    lookup = InternationalStreet::Lookup.new('CA')

    lookup.address1 = '301 Front St W'
    lookup.locality = 'Toronto'
    lookup.administrative_area = 'ON'

    begin
      client.send_lookup(lookup)
    rescue SmartyException => err
      puts err
      return
    end

    result = lookup.result

    if result == nil
      puts 'No candidates. This means the address is not valid.'
      return
    end

    first_candidate = result[0]

    puts "Address is valid. (There is at least one candidate)\n"
    puts "Postal Code: #{first_candidate.components.postal_code}"
    puts "Country Code: #{first_candidate.components.country_iso_3}"
    puts "Vertification Status: #{first_candidate.analysis.verification_status}"
    puts "Address Precision: #{first_candidate.analysis.address_precision}"
  end
end

InternationalStreetLookupExample.new.run
