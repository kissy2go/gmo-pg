require 'spec_helper'

RSpec.describe GMO::PG::SearchMember, type: :api_endpoint do
  it_behaves_like 'an API Endpoint', '/payment/SearchMember.idPass'
end

RSpec.describe GMO::PG::SearchMember::Request, type: :request do
  it_behaves_like 'a Payload', :SiteID,     :site_id
  it_behaves_like 'a Payload', :SitePass,   :site_pass
  it_behaves_like 'a Payload', :MemberID,   :member_id

  it_behaves_like 'a Request'
end

RSpec.describe GMO::PG::SearchMember::Response, type: :response do
  it_behaves_like 'a Payload', :MemberID,   :member_id
  it_behaves_like 'a Payload', :MemberName, :member_name
  it_behaves_like 'a Payload', :DeleteFlag, :delete_flag
  it_behaves_like 'a Payload', :ErrCode,    :err_code
  it_behaves_like 'a Payload', :ErrInfo,    :err_info

  it_behaves_like 'a Response'
end
