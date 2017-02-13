require_relative '../batch'
require_relative '../request'
require_relative 'candidate'

module USStreet
  class Client
    def initialize(sender, serializer)
      @sender = sender
      @serializer = serializer
    end

    def send_lookup(lookup)
      batch = Batch.new
      batch.add(lookup)
      send_batch(batch)
    end

    def send_batch(batch)
      return if batch.size == 0

      smarty_request = Request.new
      converted_lookups = remap_keys(batch.all_lookups)
      smarty_request.payload = @serializer.serialize(converted_lookups)

      response = @sender.send(smarty_request)

      raise response.error if response.error

      candidates = @serializer.deserialize(response.payload)
      candidates = [] if candidates == nil

      assign_candidates_to_lookups(batch, candidates)
    end

    def remap_keys(obj)
      obj.map(&:to_hash)
    end

    def assign_candidates_to_lookups(batch, candidates)
      candidates.each { |raw_candidate|
        candidate = Candidate.new(raw_candidate)
        batch[candidate.input_index].result.push(candidate)
      }
    end
  end
end
