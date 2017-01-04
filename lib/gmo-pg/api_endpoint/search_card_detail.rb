module GMO
  module PG
    module SearchCardDetail
      extend APIEndpoint

      class Request < GMO::PG::GenericRequest
        bind_attribute :ShopID,   :shop_id
        bind_attribute :ShopPass, :shop_pass
        bind_attribute :CardNo,   :card_no
        bind_attribute :OrderID,  :order_id
        bind_attribute :SiteID,   :site_id
        bind_attribute :SitePass, :site_pass
        bind_attribute :MemberID, :member_id
        bind_attribute :SeqMode,  :seq_mode
        bind_attribute :CardSeq,  :card_seq
      end

      class Response < GMO::PG::GenericResponse
        include ErrCodeAndErrInfo

        bind_attribute :CardNo,                 :card_no
        bind_attribute :Brand,                  :brand
        bind_attribute :DomesticFlag,           :domestic_flag
        bind_attribute :IssuerCode,             :issuer_code
        bind_attribute :DebitPrepaidFlag,       :debit_prepaid_flag
        bind_attribute :DebitPrepaidIssuerName, :debit_prepaid_issuer_name
        bind_attribute :ForwardFinal,           :forward_final
      end
    end
  end
end
