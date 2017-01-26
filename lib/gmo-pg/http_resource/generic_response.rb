module GMO
  module PG
    class GenericResponse < Payload
      def error?
        !!(err_code || err_info)
      end

      def errors
        GMO::PG::Errors.new(err_code, err_info) if error?
      end

      private

      def self.inherited(inherited)
        super
        inherited.class_eval do
          bind_attribute :ErrCode, :err_code
          bind_attribute :ErrInfo, :err_info
        end
      end
    end
  end
end
