module GMO
  module PG
    class Member
      class Card
        attr_accessor :last4, :expire, :name
      end

      attr_accessor :id, :card

      def self.create(id: nil, order_id: nil, card: nil)
        raise ArgumentError, 'id required'       unless id
        raise ArgumentError, 'order_id required' unless order_id
        raise ArgumentError, 'card required'     unless card

        GMO::PG.connect do |dispatcher|
          entry_tran = GMO::PG::EntryTran::Request.new(
            shop_id:   GMO::PG.shop_id,
            shop_pass: GMO::PG.shop_pass,
            order_id:  order_id,
            job_cd:    'CHECK',
          )

          credential = dispatcher.dispatch(entry_tran)
          raise credential.errors.first.to_error if credential.error?

          exec_tran = GMO::PG::ExecTran::Request.new(
            access_id:   credential.access_id,
            access_pass: credential.access_pass,
            order_id:    order_id,
          )
          case card
          when String
            exec_tran[:token] = card
          when Hash
            expire = '%02d%02d' % [card[:exp_year].to_s[-2..-1], card[:exp_month].to_s[-2..-1]]
            exec_tran[:card_no]       = card[:number]
            exec_tran[:expire]        = expire
            exec_tran[:security_code] = card[:cvc] if card.key?(:cvc)
          end

          transaction = dispatcher.dispatch(exec_tran)
          raise transaction.errors.first.to_error if transaction.error?

          save_member = GMO::PG::SaveMember::Request.new(
            member_id: id,
          )

          member = dispatcher.dispatch(save_member)
          raise member.errors.first.to_error if member.error?

          traded_card = GMO::PG::TradedCard::Request.new(
            shop_id:   GMO::PG.shop_id,
            shop_pass: GMO::PG.shop_pass,
            order_id:  order_id,
            site_id:   GMO::PG.site_id,
            site_pass: GMO::PG.site_pass,
            member_id: id,
          )

          card = dispatcher.dispatch(traded_card)
          raise card.errors.first.to_error if card.error?

          new(
            id:   id,
            card: Card.new(
              last4: card.card_no[-4..-1],
            ),
          )
        end
      end

      def self.retrieve(id: nil)
        raise ArgumentError, 'id required' unless id

        GMO::PG.connect do |dispatcher|
          search_card = GMO::PG::SearchCard::Request.new(
            site_id:   GMO::PG.site_id,
            site_pass: GMO::PG.site_pass,
            member_id: id,
            seq_mode:  '0',
            card_seq:  '0',
          )

          card = dispatcher.dispatch(search_card)
          raise card.errors.first.to_error if card.error?

          new(
            id:   id,
            card: Card.new(
              last4:  card.card_no[-4..-1],
              expire: card.expire,
              name:   card.holder_name,
            )
          )
        end
      end

      private

      def check_card(card: nil)
      end
    end
  end
end
