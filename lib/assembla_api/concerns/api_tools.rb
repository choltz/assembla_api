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
        def api_request(url)
          header={ "X-Api-Key" => AssemblaApi::Config.key, "X-Api-Secret" => AssemblaApi::Config.secret}
          response = Typhoeus.get(url, :headers => header)
          JSON.parse(response.body)
        end

      end

    end
  end
end
