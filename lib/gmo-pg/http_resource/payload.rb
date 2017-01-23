module GMO
  module PG
    class Payload
      def self.encode(payload)
        URI.encode_www_form(payload)
      end

      def self.decode(body)
        Hash[URI.decode_www_form(body)]
      end

      def initialize(attributes = {})
        @attributes = {}
        attributes.each do |name, value|
          self[name] = value
        end
      end

      def []=(name, value)
        param_name = self.class.detect_param_name(name)
        @attributes[param_name] = value
      end

      def [](name)
        param_name = self.class.detect_param_name(name)
        @attributes[param_name]
      end

      def payload
        @attributes.dup.freeze
      end

      def to_hash
        @attributes.each_with_object({}) do |(param_name, value), hash|
          hash[self.class.detect_attribute_name(param_name)] = value
        end
      end

      def inspect
        '#<%s:%014x "%s">' % [
          self.class.name,
          object_id << 1, # @see http://stackoverflow.com/questions/2818602/in-ruby-why-does-inspect-print-out-some-kind-of-object-id-which-is-different
          self.class.encode(payload),
        ]
      end

      private

      def self.inherited(inherited)
        inherited.class_eval do
          @bind_attributes = []
        end
      end

      def self.bind_attribute(param_name, attr_name)
        @bind_attributes << [param_name, attr_name]

        define_method(:"#{attr_name}")  { self[attr_name] }
        define_method(:"#{attr_name}=") { |value| self[attr_name] = value }
      end

      def self.detect_attribute_name(name)
        name = name.respond_to?(:to_sym) ? name.to_sym : name
        @bind_attributes.each do |(param_name, attr_name)|
          return attr_name if name == param_name || name == attr_name
        end
        name
      end

      def self.detect_param_name(name)
        name = name.respond_to?(:to_sym) ? name.to_sym : name
        @bind_attributes.each do |(param_name, attr_name)|
          return param_name if name == param_name || name == attr_name
        end
        name
      end
    end
  end
end
