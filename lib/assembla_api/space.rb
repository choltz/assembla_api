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
    end

  end
end
