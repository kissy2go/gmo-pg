module GMO
  module PG
    module AlterTran
      extend APIEndpoint

      class Request < GMO::PG::GenericRequest
        bind_attribute :ShopID,     :shop_id
        bind_attribute :ShopPass,   :shop_pass
        bind_attribute :AccessID,   :access_id
        bind_attribute :AccessPass, :access_pass
        bind_attribute :JobCd,      :job_cd
        bind_attribute :Amount,     :amount,      typecast: :integer
        bind_attribute :Tax,        :tax,         typecast: :integer
        bind_attribute :Method,     :method
        bind_attribute :PayTimes,   :pay_times,   typecast: :integer
      end

      class Response < GMO::PG::GenericResponse
        bind_attribute :AccessID,   :access_id
        bind_attribute :AccessPass, :access_pass
        bind_attribute :Forward,    :forward
        bind_attribute :Approve,    :approve
        bind_attribute :TranID,     :tran_id
        bind_attribute :TranDate,   :tran_date,   typecast: :epoch_time
      end
    end
  end
end
