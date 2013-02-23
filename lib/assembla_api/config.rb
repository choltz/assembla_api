module AssemblaApi
  # Public: Object to hold into Assembla credentials
  class Config

    #
    # Class methods
    #

    class << self
      def key
        defined?(@key) ? @key : nil
      end

      def key=(value)
        @key = value
      end

      def secret
        defined?(@secret) ? @secret : nil
      end

      def secret=(value)
        @secret = value
      end
    end

  end
end
