require 'spec_helper'

RSpec.describe GMO::PG::EntryTran, type: :api_endpoint do
  it_behaves_like 'an API Endpoint', '/payment/EntryTran.idPass'
end

RSpec.describe GMO::PG::EntryTran::Request, type: :request do
  it_behaves_like 'a Payload', :ShopID,       :shop_id
  it_behaves_like 'a Payload', :ShopPass,     :shop_pass
  it_behaves_like 'a Payload', :OrderID,      :order_id
  it_behaves_like 'a Payload', :JobCd,        :job_cd
  it_behaves_like 'a Payload', :ItemCode,     :item_code
  it_behaves_like 'a Payload', :Amount,       :amount
  it_behaves_like 'a Payload', :Tax,          :tax
  it_behaves_like 'a Payload', :TdFlag,       :td_flag
  it_behaves_like 'a Payload', :TdTenantName, :td_tenant_name

  it_behaves_like 'a typecastable parameter', :Amount, GMO::PG::Payload::TypecastableInteger
  it_behaves_like 'a typecastable parameter', :Tax,    GMO::PG::Payload::TypecastableInteger

  it_behaves_like 'a Request'
end

RSpec.describe GMO::PG::EntryTran::Response, type: :response do
  it_behaves_like 'a Payload', :AccessID,   :access_id
  it_behaves_like 'a Payload', :AccessPass, :access_pass
  it_behaves_like 'a Payload', :ErrCode,    :err_code
  it_behaves_like 'a Payload', :ErrInfo,    :err_info

  it_behaves_like 'a Response'
end
