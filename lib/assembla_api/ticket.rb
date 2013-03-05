require "assembla_api/concerns/api_tools.rb"
require "assembla_api/config"
require "json"

module AssemblaApi
  # Public: Wrapper class around the Assembla Space construct
  class Ticket
    include AssemblaApi::Concerns::ApiTools

    #
    # Class Methods
    #
    class << self

      def find_by_space_id(id)

      end

    end

  end
end
