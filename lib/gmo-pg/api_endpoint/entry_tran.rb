module GMO
  module PG
    module EntryTran
      extend APIEndpoint

      class Request < GMO::PG::GenericRequest
        bind_attribute :ShopID,       :shop_id
        bind_attribute :ShopPass,     :shop_pass
        bind_attribute :OrderID,      :order_id
        bind_attribute :JobCd,        :job_cd
        bind_attribute :ItemCode,     :item_code
        bind_attribute :Amount,       :amount
        bind_attribute :Tax,          :tax
        bind_attribute :TdFlag,       :td_flag
        bind_attribute :TdTenantName, :td_tenant_name
      end

      class Response < GMO::PG::GenericResponse
        bind_attribute :AccessID,   :access_id
        bind_attribute :AccessPass, :access_pass
      end
    end
  end
end
