module AssemblaApi
  # Public: Ok not a really a concern, as we don't depend on active support. This
  # is a typical module to extend classes.
  module Concerns
    module ApiTools
      def self.included(base)
        base.extend ClassMethods
      end

      module ClassMethods
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

          # if there's no data set to nil, otherwise parse the JSON
          results = ( results.nil? || (results.is_a?(String) && results.strip == "") ? nil : JSON.parse(results) )

          # raise an exception if the API returns an error
          raise results["error"] if results.is_a?(Hash) && !results["error"].nil?

          results
        end

        # Internal: Create an instance of the instance object from a hash
        #
        # hash - hash with values returned from the API call
        #
        # Returns a populated instance of the instance object
        def build_from_hash(hash)
          instance = self.new

          # Add the instance attributes dynamically from the hash. If the attribute
          # does not already exist, then don't re-add the attribute class and
          # variable, just set it with the value from the hash
          hash.keys.each do |key|
            class_eval { attr_accessor key } unless instance.methods.include?(key.to_sym)
            instance.instance_variable_set "@#{key}", hash[key]
          end

          instance
        end

      end
    end
  end
end
