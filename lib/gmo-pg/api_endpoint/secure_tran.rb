module GMO
  module PG
    module SecureTran
      extend APIEndpoint

      class Request < GMO::PG::GenericRequest
        bind_attribute :PaRes, :pa_res
        bind_attribute :MD,    :md
      end

      class Response < GMO::PG::GenericResponse
        bind_attribute :OrderID,      :order_id
        bind_attribute :Forward,      :forward
        bind_attribute :Method,       :method
        bind_attribute :PayTimes,     :pay_times,      typecast: :integer
        bind_attribute :Approve,      :approve
        bind_attribute :TranID,       :tran_id
        bind_attribute :TranDate,     :tran_date,      typecast: :epoch_time
        bind_attribute :CheckString,  :check_string
        bind_attribute :ClientField1, :client_field_1
        bind_attribute :ClientField2, :client_field_2
        bind_attribute :ClientField3, :client_field_3
        bind_attribute :ClientField3, :client_field_3
      end
    end
  end
end
