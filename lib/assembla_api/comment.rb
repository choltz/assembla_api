require "assembla_api/config"
require "json"

module AssemblaApi
  # Public: Wrapper class around the Assembla Ticket construct
  class Comment
    include AssemblaApi::Concerns::ApiTools

    # attr_accessor :space_id

    #
    # Class Methods
    #
    class << self
      # Public: return instance objects for all tickets
      def all(space_id, ticket_number)
        response = api_request("https://api.assembla.com/v1/spaces/#{space_id}/tickets/#{ticket_number}/ticket_comments")
        response.map{ |result| build_from_hash(result) }
      end

      # Public: Create a new ticket with the arguments specified
      #
      # Returns an instance of the ticket object
      def create(*args)
        options = args.first
        raise "space_id is required when creating a comment" if !options.keys.include?(:space_id)
        raise "ticket_number is required when creating a comment" if !options.keys.include?(:ticket_number)

        response = api_request "https://api.assembla.com/v1/spaces/#{options[:space_id]}/tickets/#{options[:ticket_number]}/ticket_comments", :method => :post, :body =>  {"ticket_comment" => options }

        build_from_hash(response)
      end
    end
  end
end
