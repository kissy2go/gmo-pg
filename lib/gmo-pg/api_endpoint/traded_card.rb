module GMO
  module PG
    module TradedCard
      extend APIEndpoint

      class Request < GMO::PG::GenericRequest
        bind_attribute :ShopID,      :shop_id
        bind_attribute :ShopPass,    :shop_pass
        bind_attribute :OrderID,     :order_id
        bind_attribute :SiteID,      :site_id
        bind_attribute :SitePass,    :site_pass
        bind_attribute :MemberID,    :member_id
        bind_attribute :SeqMode,     :seq_mode
        bind_attribute :DefaultFlag, :default_flag
        bind_attribute :HolderName,  :holder_name
      end

      class Response < GMO::PG::GenericResponse
        include ErrCodeAndErrInfo

        bind_attribute :CardSeq, :card_seq
        bind_attribute :CardNo,  :card_no
        bind_attribute :Forward, :forward
      end
    end
  end
end
