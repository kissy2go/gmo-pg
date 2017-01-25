require 'spec_helper'

RSpec.describe GMO::PG::DeleteCard, type: :api_endpoint do
  it_behaves_like 'an API Endpoint', '/payment/DeleteCard.idPass'
end

RSpec.describe GMO::PG::DeleteCard::Request, type: :request do
  it_behaves_like 'a Payload', :SiteID,   :site_id
  it_behaves_like 'a Payload', :SitePass, :site_pass
  it_behaves_like 'a Payload', :MemberID, :member_id
  it_behaves_like 'a Payload', :SeqMode,  :seq_mode
  it_behaves_like 'a Payload', :CardSeq,  :card_seq

  it_behaves_like 'a typecastable parameter', :CardSeq, GMO::PG::Payload::TypecastableInteger

  it_behaves_like 'a Request'
end

RSpec.describe GMO::PG::DeleteCard::Response, type: :response do
  it_behaves_like 'a Payload', :CardSeq, :card_seq
  it_behaves_like 'a Payload', :ErrCode, :err_code
  it_behaves_like 'a Payload', :ErrInfo, :err_info

  it_behaves_like 'a typecastable parameter', :CardSeq, GMO::PG::Payload::TypecastableInteger

  it_behaves_like 'a Response'
end
