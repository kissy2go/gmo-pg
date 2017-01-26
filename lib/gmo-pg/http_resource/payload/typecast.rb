module GMO
  module PG
    class Payload
      module Typecast
        def self.detect(typecast_option)
          case typecast_option
          when /\Ainteger\z/    then TypecastableInteger
          when /\Aepoch_time\Z/ then TypecastableEpochTime
          when Hash             then TypecastableValue.from_hash(typecast_option)
          else TypecastableValue
          end
        end
      end

      class TypecastableValue
        attr_accessor :value

        def self.from_hash(typecast_option)
          Class.new(self) do
            define_method :to_attribute do
              return super() unless typecast_option[:to_attribute].is_a?(Proc)
              typecast_option[:to_attribute].call(@value) rescue super()
            end

            define_method :to_payload do
              return super() unless typecast_option[:to_payload].is_a?(Proc)
              typecast_option[:to_payload].call(@value) rescue super()
            end
          end
        end

        def initialize(value)
          @value = value
        end

        def to_attribute
          @value
        end

        def to_payload
          @value.to_s
        end

        def ==(other)
          other_value = other.is_a?(self.class) ? other.to_payload : other
          to_payload == other_value
        end
      end

      class TypecastableInteger < TypecastableValue
        def to_attribute
          @value.respond_to?(:to_i) ? @value.to_i : @value
        end

        def to_payload
          to_attribute.to_s
        end
      end

      class TypecastableEpochTime < TypecastableInteger
        TIME_ZONE = '+09:00'
        FORMAT    = '%Y%m%d%H%M%S'

        def format
          FORMAT
        end

        def to_attribute
          time =
            case @value
            when Time
              @value
            when DateTime
              Time.new(@value.year, @value.month, @value.day, @value.hour, @value.min, @value.sec)
            else
              Time.strptime(@value, format) rescue return super
            end
          time.to_i rescue super
        end

        def to_payload
          Time.at(to_attribute).localtime(TIME_ZONE).strftime(format) rescue super
        end
      end
    end
  end
end
