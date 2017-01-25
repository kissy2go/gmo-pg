module GMO
  module PG
    module SearchTrade
      extend APIEndpoint

      class Request < GMO::PG::GenericRequest
        bind_attribute :ShopID,   :shop_id
        bind_attribute :ShopPass, :shop_pass
        bind_attribute :OrderID,  :order_id
      end

      class Response < GMO::PG::GenericResponse
        bind_attribute :OrderID,      :order_id
        bind_attribute :Status,       :status
        bind_attribute :ProcessDate,  :process_date,   typecast: :epoch_time
        bind_attribute :JobCd,        :job_cd
        bind_attribute :AccessID,     :access_id
        bind_attribute :AccessPass,   :access_pass
        bind_attribute :ItemCode,     :item_code
        bind_attribute :Amount,       :amount,         typecast: :integer
        bind_attribute :Tax,          :tax,            typecast: :integer
        bind_attribute :SiteID,       :site_id
        bind_attribute :MemberID,     :member_id
        bind_attribute :CardNo,       :card_no
        bind_attribute :Expire,       :expire
        bind_attribute :Method,       :method
        bind_attribute :PayTimes,     :pay_times,      typecast: :integer
        bind_attribute :Forward,      :forward
        bind_attribute :TranID,       :tran_id
        bind_attribute :Approve,      :approve
        bind_attribute :ClientField1, :client_field_1
        bind_attribute :ClientField2, :client_field_2
        bind_attribute :ClientField3, :client_field_3
      end
    end
  end
end
