require 'spec_helper'

RSpec.describe GMO::PG::SecureTran, type: :api_endpoint do
  it_behaves_like 'an API Endpoint', '/payment/SecureTran.idPass'
end

RSpec.describe GMO::PG::SecureTran::Request, type: :request do
  it_behaves_like 'a Payload', :PaRes, :pa_res
  it_behaves_like 'a Payload', :MD,    :md

  it_behaves_like 'a Request'
end

RSpec.describe GMO::PG::SecureTran::Response, type: :response do
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
  it_behaves_like 'a Payload', :ErrCode,      :err_code
  it_behaves_like 'a Payload', :ErrInfo,      :err_info

  it_behaves_like 'a Response'
end
