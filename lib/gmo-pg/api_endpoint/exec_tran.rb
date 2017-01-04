module GMO
  module PG
    module ExecTran
      extend APIEndpoint

      class Request < GMO::PG::GenericRequest
        bind_attribute :AccessID,        :access_id
        bind_attribute :AccessPass,      :access_pass
        bind_attribute :OrderID,         :order_id
        bind_attribute :Method,          :method
        bind_attribute :PayTimes,        :pay_times
        bind_attribute :CardNo,          :card_no
        bind_attribute :Expire,          :expire
        bind_attribute :SiteID,          :site_id
        bind_attribute :SitePass,        :site_pass
        bind_attribute :MemberID,        :member_id
        bind_attribute :SeqMode,         :seq_mode
        bind_attribute :CardSeq,         :card_seq
        bind_attribute :CardPass,        :card_pass
        bind_attribute :SecurityCode,    :security_code
        bind_attribute :Token,           :token
        bind_attribute :PIN,             :pin
        bind_attribute :HttpAccept,      :http_accept
        bind_attribute :HttpUserAgent,   :http_user_agent
        bind_attribute :DeviceCategory,  :device_category
        bind_attribute :ClientField1,    :client_field_1
        bind_attribute :ClientField2,    :client_field_2
        bind_attribute :ClientField3,    :client_field_3
        bind_attribute :ClientFieldFlag, :client_field_flag
      end

      class Response < GMO::PG::GenericResponse
        include ErrCodeAndErrInfo

        bind_attribute :ACS,          :acs
        bind_attribute :OrderID,      :order_id
        bind_attribute :Forward,      :forward
        bind_attribute :Method,       :method
        bind_attribute :PayTimes,     :pay_times
        bind_attribute :Approve,      :approve
        bind_attribute :TranID,       :tran_id
        bind_attribute :TranDate,     :tran_date
        bind_attribute :CheckString,  :check_string
        bind_attribute :ClientField1, :client_field_1
        bind_attribute :ClientField2, :client_field_2
        bind_attribute :ClientField3, :client_field_3
        bind_attribute :ACSUrl,       :acs_url
        bind_attribute :PaReq,        :pa_req
        bind_attribute :MD,           :md
      end
    end
  end
end
