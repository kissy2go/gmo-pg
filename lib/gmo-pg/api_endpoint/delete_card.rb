module GMO
  module PG
    module DeleteCard
      extend APIEndpoint

      class Request < GMO::PG::GenericRequest
        bind_attribute :SiteID,   :site_id
        bind_attribute :SitePass, :site_pass
        bind_attribute :MemberID, :member_id
        bind_attribute :SeqMode,  :seq_mode
        bind_attribute :CardSeq,  :card_seq,  typecast: :integer
      end

      class Response < GMO::PG::GenericResponse
        bind_attribute :CardSeq, :card_seq, typecast: :integer
      end
    end
  end
end
