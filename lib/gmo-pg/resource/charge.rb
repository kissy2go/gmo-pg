module GMO
  module PG
    class Charge
      attr_accessor :id, :amount, :tax

      def self.create(id: nil, amount: nil, tax: nil, capture: true, source: nil, card: nil, item_code: nil)
        raise ArgumentError, 'id required'             unless id
        raise ArgumentError, 'amount required'         unless amount
        raise ArgumentError, 'source or card required' unless source || card

        job_cd = capture ? 'CAPTURE' : 'AUTH'

        GMO::PG.connect do |dispatcher|
          entry_tran = GMO::PG::EntryTran::Request.new(
            shop_id:   GMO::PG.shop_id,
            shop_pass: GMO::PG.shop_pass,
            order_id:  id,
            job_cd:    job_cd,
            amount:    amount.to_i.abs,
          )
          entry_tran.tax       = tax.to_i.abs if tax
          entry_tran.item_code = item_code    if item_code

          credential = dispatcher.dispatch(entry_tran)
          raise credential.errors.first.to_error if credential.error?

          exec_tran = GMO::PG::ExecTran::Request.new(
            access_id:   credential.access_id,
            access_pass: credential.access_pass,
            order_id:    id,
            method:      0,
          )
          if source
            exec_tran.site_id   = GMO::PG.site_id
            exec_tran.site_pass = GMO::PG.site_pass
            exec_tran.member_id = source
            exec_tran.seq_mode  = '0'
            exec_tran.card_seq  = '0'
          else
            case card
            when String
              exec_tran.token = card
            when Hash
              expire = '%02d%02d' % [card[:exp_year].to_s[-2..-1], card[:exp_month].to_s[-2..-1]]
              exec_tran.card_no       = card[:number]
              exec_tran.expire        = expire
              exec_tran.security_code = card[:cvc] if card.key?(:cvc)
            end
          end

          transaction = dispatcher.dispatch(exec_tran)
          raise transaction.errors.first.to_error if transaction.error?

          new(
            id:          id,
            status:      job_cd,
            proceeded:   transaction.tran_date,
            job_cd:      job_cd,
            access_id:   credential.access_id,
            access_pass: credential.access_pass,
            item_code:   item_code,
            amount:      entry_tran.amount,
            tax:         entry_tran.tax,
            method:      transaction.method,
            pay_times:   transaction.pay_times,
            forward:     transaction.forward,
            tran_id:     transaction.tran_id,
            approve:     transaction.approve,
          ).tap do |charge|
            if source
              charge.site_id   = GMO::PG.site_id
              charge.member_id = source
            else
              case card
              when Hash
                charge.card_no = ('*' * exec_tran.card_no[0...-4].count) + exec_tran.card_no[-4..-1]
                charge.expire  = exec_tran.expire
              end
            end
          end
        end
      end

      def self.retrieve(id: nil)
        raise ArgumentError, 'id required' unless id

        GMO::PG.connect do |dispatcher|
          search_trade = GMO::PG::SearchTrade::Request.new(
            shop_id:   GMO::PG.shop_id,
            shop_pass: GMO::PG.shop_pass,
            order_id:  id,
          )

          transaction = dispatcher.dispatch(search_trade)
          raise transaction.errors.first.to_error if transaction.error?

          new(
            id:          id,
            status:      transaction.status,
            proceeded:   transaction.process_date,
            job_cd:      transaction.job_cd,
            access_id:   transaction.access_id,
            access_pass: transaction.access_pass,
            item_code:   transaction.item_code,
            amount:      transaction.amount,
            tax:         transaction.tax,
            site_id:     transaction.site_id,
            member_id:   transaction.member_id,
            card_no:     transaction.card_no,
            expire:      transaction.expire,
            method:      transaction.method,
            pay_times:   transaction.pay_times,
            forward:     transaction.forward,
            tran_id:     transaction.tran_id,
            approve:     transaction.approve,
          )
        end
      end

      def capture
        update job_cd: 'SALES'
      end

      def refund
        update job_cd: (
          if proceeded_at_today?
            'VOID'
          elsif proceeded_at_month?
            'RETURN'
          else
            'RETURNX'
          end
        )
      end

      def proceeded_at_today?
        Time.new.strftime('%F') == Time.at(proceeded).strftime('%F')
      end

      def proceeded_at_month?
        Time.new.strftime('%Y-%m') == Time.at(proceeded).strftime('%Y-%m')
      end

      private

      def update(job_cd: job_cd)
        GMO::PG.connect do |dispatcher|
          alter_tran = GMO::PG::AlterTran::Request.new(
            shop_id:     GMO::PG.shop_id,
            shop_pass:   GMO::PG.shop_pass,
            access_id:   access_id,
            access_pass: access_pass,
            job_cd:      job_cd,
            amount:      amount,
          )

          transaction = dispatcher.dispatch(alter_tran)
          raise transaction.errors.first.to_error if transaction.error?

          self.status    = job_cd
          self.job_cd    = job_cd
          self.forward   = transaction.forward
          self.approve   = transaction.approve
          self.tran_id   = transaction.tran_id
          self.proceeded = transaction.proceeded

          self
        end
      end
    end
  end
end
