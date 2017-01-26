module GMO
  module PG
    class Errors
      class Record < Struct.new(:err_code, :err_info)
        def to_error
          GMO::PG::Error.from_api_error(err_code, err_info)
        end
      end

      include Enumerable

      SEPARATOR = '|'

      def initialize(err_code, err_info)
        @err_code = err_code.split(SEPARATOR) unless err_code.nil?
        @err_info = err_info.split(SEPARATOR) unless err_info.nil?
      end

      def each
        return to_enum unless block_given?
        return nil if @err_code.nil? && @err_info.nil?
        @err_code.zip(@err_info).each do |(err_code, err_info)|
          yield Record.new(err_code, err_info)
        end
      end
    end
  end
end
