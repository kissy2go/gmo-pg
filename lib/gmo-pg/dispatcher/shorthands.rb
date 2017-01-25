module GMO
  module PG
    class Dispatcher
      module Shorthands
        private

        def self.register_shorthand(endpoint, name)
          define_method :"dispatch_#{name}" do |attributes|
            dispatch(endpoint::Request.new(attributes))
          end
        end

        register_shorthand GMO::PG::EntryTran,        :entry_tran
        register_shorthand GMO::PG::ExecTran,         :exec_tran
        register_shorthand GMO::PG::SecureTran,       :secure_tran
        register_shorthand GMO::PG::SaveMember,       :save_member
        register_shorthand GMO::PG::UpdateMember,     :update_member
        register_shorthand GMO::PG::DeleteMember,     :delete_member
        register_shorthand GMO::PG::SearchMember,     :search_member
        register_shorthand GMO::PG::SaveCard,         :save_card
        register_shorthand GMO::PG::DeleteCard,       :delete_card
        register_shorthand GMO::PG::SearchCard,       :search_card
        register_shorthand GMO::PG::AlterTran,        :alter_tran
        register_shorthand GMO::PG::ChangeTran,       :change_tran
        register_shorthand GMO::PG::SearchTrade,      :search_trade
        register_shorthand GMO::PG::TradedCard,       :traded_card
        register_shorthand GMO::PG::SearchCardDetail, :search_card_detail
      end
    end
  end
end
