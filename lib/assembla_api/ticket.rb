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

      # Public: Create a new ticket with the arguments specified
      #
      # Returns an instance of the ticket object
      def create(*args)
        options = args.first
        raise "space_id is required when creating a ticket" if !options.keys.include?(:space_id)

        body = options.dup
        body.delete(:space_id)
        body = {"ticket" => body }

        response = api_request("https://api.assembla.com/v1/spaces/#{options[:space_id]}/tickets.json", :method => :post, :body => body)
        build_from_hash(response)
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
      def api_request(url, options={})
        options = { :method => :get }.update(options)
        header={ "X-Api-Key" => AssemblaApi::Config.key, "X-Api-Secret" => AssemblaApi::Config.secret, "Content-type" => "application/json" }

        response = Typhoeus::Request.new(url,
                                         :method  => options[:method],
                                         :body    =>  options[:body].nil? ? "" : options[:body].to_json,
                                         :headers => header).run

        results = response.body

        # return nil if there's no data, otherwise parse the JSON
        results.nil? || (results.is_a?(String) && results.strip == "") ? nil : JSON.parse(results)
      end

    end

  end
end
