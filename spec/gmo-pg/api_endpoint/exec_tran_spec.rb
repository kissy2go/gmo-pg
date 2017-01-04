require 'spec_helper'

RSpec.describe GMO::PG::ExecTran, type: :api_endpoint do
  it_behaves_like 'an API Endpoint', '/payment/ExecTran.idPass'
end

RSpec.describe GMO::PG::ExecTran::Request, type: :request do
  it_behaves_like 'a Payload', :AccessID,        :access_id
  it_behaves_like 'a Payload', :AccessPass,      :access_pass
  it_behaves_like 'a Payload', :OrderID,         :order_id
  it_behaves_like 'a Payload', :Method,          :method
  it_behaves_like 'a Payload', :PayTimes,        :pay_times
  it_behaves_like 'a Payload', :CardNo,          :card_no
  it_behaves_like 'a Payload', :Expire,          :expire
  it_behaves_like 'a Payload', :SiteID,          :site_id
  it_behaves_like 'a Payload', :SitePass,        :site_pass
  it_behaves_like 'a Payload', :MemberID,        :member_id
  it_behaves_like 'a Payload', :SeqMode,         :seq_mode
  it_behaves_like 'a Payload', :CardSeq,         :card_seq
  it_behaves_like 'a Payload', :CardPass,        :card_pass
  it_behaves_like 'a Payload', :SecurityCode,    :security_code
  it_behaves_like 'a Payload', :Token,           :token
  it_behaves_like 'a Payload', :PIN,             :pin
  it_behaves_like 'a Payload', :HttpAccept,      :http_accept
  it_behaves_like 'a Payload', :HttpUserAgent,   :http_user_agent
  it_behaves_like 'a Payload', :DeviceCategory,  :device_category
  it_behaves_like 'a Payload', :ClientField1,    :client_field_1
  it_behaves_like 'a Payload', :ClientField2,    :client_field_2
  it_behaves_like 'a Payload', :ClientField3,    :client_field_3
  it_behaves_like 'a Payload', :ClientFieldFlag, :client_field_flag

  it_behaves_like 'a Request'
end

RSpec.describe GMO::PG::ExecTran::Response, type: :response do
  it_behaves_like 'a Payload', :ACS,          :acs
  it_behaves_like 'a Payload', :OrderID,      :order_id
  it_behaves_like 'a Payload', :Forward,      :forward
  it_behaves_like 'a Payload', :Method,       :method
  it_behaves_like 'a Payload', :PayTimes,     :pay_times
  it_behaves_like 'a Payload', :Approve,      :approve
  it_behaves_like 'a Payload', :TranID,       :tran_id
  it_behaves_like 'a Payload', :TranDate,     :tran_date
  it_behaves_like 'a Payload', :CheckString,  :check_string
  it_behaves_like 'a Payload', :ClientField1, :client_field_1
  it_behaves_like 'a Payload', :ClientField2, :client_field_2
  it_behaves_like 'a Payload', :ClientField3, :client_field_3
  it_behaves_like 'a Payload', :ACSUrl,       :acs_url
  it_behaves_like 'a Payload', :PaReq,        :pa_req
  it_behaves_like 'a Payload', :MD,           :md
  it_behaves_like 'a Payload', :ErrCode,      :err_code
  it_behaves_like 'a Payload', :ErrInfo,      :err_info

  it_behaves_like 'a Response'
end
