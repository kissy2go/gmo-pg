require 'spec_helper'

describe GMO::PG::Dispatcher::Shorthands do
  let(:dispatcher) { GMO::PG::Dispatcher.new('https://example.com') }

  shared_examples 'a shorthand method' do |endpoint, name|
    describe "#dispatch_#{name}" do
      subject { dispatcher.send(:"dispatch_#{name}", attributes) }

      let(:attributes) { { Request: 'Payload'} }

      it 'dispatches request, and returns response' do
        stub_request(:post, dispatcher.base_url + endpoint.endpoint_path)
          .with(body: 'Request=Payload').and_return(status: 200, body: 'Response=Payload')

        expect(subject).to be_instance_of endpoint::Response
        expect(subject[:Response]).to eq 'Payload'
      end
    end
  end

  it_behaves_like 'a shorthand method', GMO::PG::EntryTran,        :entry_tran
  it_behaves_like 'a shorthand method', GMO::PG::ExecTran,         :exec_tran
  it_behaves_like 'a shorthand method', GMO::PG::SecureTran,       :secure_tran
  it_behaves_like 'a shorthand method', GMO::PG::SaveMember,       :save_member
  it_behaves_like 'a shorthand method', GMO::PG::UpdateMember,     :update_member
  it_behaves_like 'a shorthand method', GMO::PG::DeleteMember,     :delete_member
  it_behaves_like 'a shorthand method', GMO::PG::SearchMember,     :search_member
  it_behaves_like 'a shorthand method', GMO::PG::SaveCard,         :save_card
  it_behaves_like 'a shorthand method', GMO::PG::DeleteCard,       :delete_card
  it_behaves_like 'a shorthand method', GMO::PG::SearchCard,       :search_card
  it_behaves_like 'a shorthand method', GMO::PG::AlterTran,        :alter_tran
  it_behaves_like 'a shorthand method', GMO::PG::ChangeTran,       :change_tran
  it_behaves_like 'a shorthand method', GMO::PG::SearchTrade,      :search_trade
  it_behaves_like 'a shorthand method', GMO::PG::TradedCard,       :traded_card
  it_behaves_like 'a shorthand method', GMO::PG::SearchCardDetail, :search_card_detail
end
