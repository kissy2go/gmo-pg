module GMO
  module PG
    class Errors
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
          yield err_code, err_info
        end
      end
    end
  end
end
