module GMO
  module PG
    class GenericRequest < Payload
      attr_accessor :path

      def self.corresponding_response_class
        @corresponding_response_class ||= detect_corresponding_response_class
      end

      def path
        @path ||= self.class.detect_endpoint_path
      end

      private

      def self.detect_endpoint_module
        endpoint = Object.const_get(self.name.split('::')[0...-1].join('::'))
        endpoint.is_a?(GMO::PG::APIEndpoint) ? endpoint : nil
      end

      def self.detect_endpoint_path
        endpoint = detect_endpoint_module
        endpoint ? endpoint.endpoint_path : nil
      rescue NameError
        nil
      end

      def self.detect_corresponding_response_class
        endpoint = detect_endpoint_module
        endpoint ? endpoint.const_get(:Response) : nil
      rescue NameError
        nil
      end
    end
  end
end
