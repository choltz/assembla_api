require "assembla_api/config"
require "json"

module AssemblaApi
  # Public: Wrapper class around the Assembla Ticket construct
  class Ticket
    attr_accessor :space_id

    #
    # Class Methods
    #
    class << self
      # Public: return instance objects for all tickets
      def all(space_id)
        response = api_request("https://api.assembla.com/v1/spaces/#{space_id}/tickets.json")
        response.map{ |result| build_from_hash(result) }
      end

      private

      # Internal: Create an instance of the ticket object from a hash
      #
      # hash - hash with values returned from the API call
      #
      # Returns a populated instance of the ticket object
      def build_from_hash(hash)
        ticket = self.new

        # Add the attributes dynamically from the hash. If the attribute
        # does not already exist, then don't re-add the attribute class and
        # variable, just set it with the value from the hash
        hash.keys.each do |key|
          class_eval { attr_accessor key } unless ticket.methods.include?(key.to_sym)
          ticket.instance_variable_set "@#{key}", hash[key]
        end

        ticket
      end

      # Internal: parses the response json and returns it as a hash. This exists
      # as a method for stubbing convenience in unit tests
      def api_request(url)
        header={ "X-Api-Key" => AssemblaApi::Config.key, "X-Api-Secret" => AssemblaApi::Config.secret}
        response = Typhoeus.get(url, :headers => header)
        JSON.parse(response.body)
      end

    end

  end
end
