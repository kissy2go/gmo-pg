require 'spec_helper'

describe GMO::PG::Dispatcher::Shorthands do
  let(:dispatcher) { GMO::PG::Dispatcher.new('https://example.com') }

  shared_examples 'a shorthand method' do |endpoint, name|
    describe "#dispatch_#{name}" do
      subject { dispatcher.send(:"dispatch_#{name}", attributes) }

      let(:attributes) { {} }

      it 'dispatches request, and returns response' do
        request_mock = spy(endpoint::Request.to_s)

        expect(endpoint::Request).to receive(:new)
          .with(attributes)
          .and_return(request_mock)
        expect(dispatcher).to receive(:dispatch)
          .with(request_mock)
          .and_return(:ok)

        expect(subject).to eq :ok
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
