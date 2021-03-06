require 'spec_helper'

RSpec.describe GMO::PG::AlterTran, type: :api_endpoint do
  it_behaves_like 'an API Endpoint', '/payment/AlterTran.idPass'
end

RSpec.describe GMO::PG::AlterTran::Request, type: :request do
  it_behaves_like 'a Payload', :ShopID,     :shop_id
  it_behaves_like 'a Payload', :ShopPass,   :shop_pass
  it_behaves_like 'a Payload', :AccessID,   :access_id
  it_behaves_like 'a Payload', :AccessPass, :access_pass
  it_behaves_like 'a Payload', :JobCd,      :job_cd
  it_behaves_like 'a Payload', :Amount,     :amount
  it_behaves_like 'a Payload', :Tax,        :tax
  it_behaves_like 'a Payload', :Method,     :method
  it_behaves_like 'a Payload', :PayTimes,   :pay_times

  it_behaves_like 'a typecastable parameter', :Amount,   GMO::PG::Payload::TypecastableInteger
  it_behaves_like 'a typecastable parameter', :Tax,      GMO::PG::Payload::TypecastableInteger
  it_behaves_like 'a typecastable parameter', :PayTimes, GMO::PG::Payload::TypecastableInteger

  it_behaves_like 'a Request'
end

RSpec.describe GMO::PG::AlterTran::Response, type: :response do
  it_behaves_like 'a Payload', :AccessID,   :access_id
  it_behaves_like 'a Payload', :AccessPass, :access_pass
  it_behaves_like 'a Payload', :Forward,    :forward
  it_behaves_like 'a Payload', :Approve,    :approve
  it_behaves_like 'a Payload', :TranID,     :tran_id
  it_behaves_like 'a Payload', :TranDate,   :tran_date
  it_behaves_like 'a Payload', :ErrCode,    :err_code
  it_behaves_like 'a Payload', :ErrInfo,    :err_info

  it_behaves_like 'a typecastable parameter', :TranDate, GMO::PG::Payload::TypecastableEpochTime

  it_behaves_like 'a Response'
end
