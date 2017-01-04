require 'spec_helper'

RSpec.describe GMO::PG::ChangeTran, type: :api_endpoint do
  it_behaves_like 'an API Endpoint', '/payment/ChangeTran.idPass'
end

RSpec.describe GMO::PG::ChangeTran::Request, type: :request do
  it_behaves_like 'a Payload', :ShopID,       :shop_id
  it_behaves_like 'a Payload', :ShopPass,     :shop_pass
  it_behaves_like 'a Payload', :AccessID,     :access_id
  it_behaves_like 'a Payload', :AccessPass,   :access_pass
  it_behaves_like 'a Payload', :JobCd,        :job_cd
  it_behaves_like 'a Payload', :Amount,       :amount
  it_behaves_like 'a Payload', :Tax,          :tax

  it_behaves_like 'a Request'
end

RSpec.describe GMO::PG::ChangeTran::Response, type: :response do
  it_behaves_like 'a Payload', :AccessID,   :access_id
  it_behaves_like 'a Payload', :AccessPass, :access_pass
  it_behaves_like 'a Payload', :Forward,    :forward
  it_behaves_like 'a Payload', :Approve,    :approve
  it_behaves_like 'a Payload', :TranID,     :tran_id
  it_behaves_like 'a Payload', :TranDate,   :tran_date
  it_behaves_like 'a Payload', :ErrCode,    :err_code
  it_behaves_like 'a Payload', :ErrInfo,    :err_info

  it_behaves_like 'a Response'
end
