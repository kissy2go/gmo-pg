require 'spec_helper'

RSpec.describe GMO::PG::DeleteMember, type: :api_endpoint do
  it_behaves_like 'an API Endpoint', '/payment/DeleteMember.idPass'
end

RSpec.describe GMO::PG::DeleteMember::Request, type: :request do
  it_behaves_like 'a Payload', :SiteID,   :site_id
  it_behaves_like 'a Payload', :SitePass, :site_pass
  it_behaves_like 'a Payload', :MemberID, :member_id

  it_behaves_like 'a Request'
end

RSpec.describe GMO::PG::DeleteMember::Response, type: :response do
  it_behaves_like 'a Payload', :MemberID, :member_id
  it_behaves_like 'a Payload', :ErrCode,  :err_code
  it_behaves_like 'a Payload', :ErrInfo,  :err_info

  it_behaves_like 'a Response'
end
