require 'spec_helper'

RSpec.describe GMO::PG::SearchTrade, type: :api_endpoint do
  it_behaves_like 'an API Endpoint', '/payment/SearchTrade.idPass'
end

RSpec.describe GMO::PG::SearchTrade::Request, type: :request do
  it_behaves_like 'a Payload', :ShopID,   :shop_id
  it_behaves_like 'a Payload', :ShopPass, :shop_pass
  it_behaves_like 'a Payload', :OrderID,  :order_id

  it_behaves_like 'a Request'
end

RSpec.describe GMO::PG::SearchTrade::Response, type: :response do
  it_behaves_like 'a Payload', :OrderID,      :order_id
  it_behaves_like 'a Payload', :Status,       :status
  it_behaves_like 'a Payload', :ProcessDate,  :process_date
  it_behaves_like 'a Payload', :JobCd,        :job_cd
  it_behaves_like 'a Payload', :AccessID,     :access_id
  it_behaves_like 'a Payload', :AccessPass,   :access_pass
  it_behaves_like 'a Payload', :ItemCode,     :item_code
  it_behaves_like 'a Payload', :Amount,       :amount
  it_behaves_like 'a Payload', :Tax,          :tax
  it_behaves_like 'a Payload', :SiteID,       :site_id
  it_behaves_like 'a Payload', :MemberID,     :member_id
  it_behaves_like 'a Payload', :CardNo,       :card_no
  it_behaves_like 'a Payload', :Expire,       :expire
  it_behaves_like 'a Payload', :Method,       :method
  it_behaves_like 'a Payload', :PayTimes,     :pay_times
  it_behaves_like 'a Payload', :Forward,      :forward
  it_behaves_like 'a Payload', :TranID,       :tran_id
  it_behaves_like 'a Payload', :Approve,      :approve
  it_behaves_like 'a Payload', :ClientField1, :client_field_1
  it_behaves_like 'a Payload', :ClientField2, :client_field_2
  it_behaves_like 'a Payload', :ClientField3, :client_field_3
  it_behaves_like 'a Payload', :ErrCode,      :err_code
  it_behaves_like 'a Payload', :ErrInfo,      :err_info

  it_behaves_like 'a typecastable parameter', :ProcessDate, GMO::PG::Payload::TypecastableEpochTime
  it_behaves_like 'a typecastable parameter', :Amount,      GMO::PG::Payload::TypecastableInteger
  it_behaves_like 'a typecastable parameter', :Tax,         GMO::PG::Payload::TypecastableInteger
  it_behaves_like 'a typecastable parameter', :PayTimes,    GMO::PG::Payload::TypecastableInteger

  it_behaves_like 'a Response'
end
