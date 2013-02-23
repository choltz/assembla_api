require "assembla_api/config"
require "json"

module AssemblaApi
  # Public: Wrapper class around the Assembla Space construct
  class Space

    #
    # Class Methods
    #
    class << self
      # Public: return instance objects for all spaces
      def all
        response = api_request("https://api.assembla.com/v1/spaces.json")
        response.map{ |result| build_from_hash(result) }
      end

      private

      # Internal: Create an instance of the space object from a hash
      #
      # hash - hash with values returned from the API call
      #
      # Returns a populated instance of the space object
      def build_from_hash(hash)
        space = self.new

        # Add the space attributes dynamically from the hash. If the attribute
        # does not already exist, then don't re-add the attribute class and
        # variable, just set it with the value from the hash
        hash.keys.each do |key|
          class_eval { attr_accessor key } unless space.methods.include?(key.to_sym)
          space.instance_variable_set "@#{key}", hash[key]
        end

        space
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
