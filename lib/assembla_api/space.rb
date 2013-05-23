require "assembla_api/concerns/api_tools.rb"
require "assembla_api/config"
require "json"

module AssemblaApi
  # Public: Wrapper class around the Assembla Space construct
  class Space
    include AssemblaApi::Concerns::ApiTools

    # Public: Return the tickets associated with this space
    def tickets
      AssemblaApi::Ticket.find_by_space_id(self.id)
    end

    #
    # Instance Methods
    #

    # Public: returns a list of tickets associated with the space.
    # By default, the first 1000 tickets are returned
    def tickets
      AssemblaApi::Ticket.all(self.id)
    end

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

    end

  end
end
