require "assembla_api/config"
require "json"

module AssemblaApi
  # Public: Wrapper class around the Assembla Ticket construct
  class User
    include AssemblaApi::Concerns::ApiTools

    #
    # Class Methods
    #
    class << self
      # Public: Find a user by their id or login
      #
      # Returns a user instance
      def find(id)
        response = api_request("https://api.assembla.com/v1/users/#{id}.json")
        build_from_hash(response)
      end

    end

  end
end
