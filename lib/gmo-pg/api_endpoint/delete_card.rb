module GMO
  module PG
    module DeleteCard
      extend APIEndpoint

      class Request < GMO::PG::GenericRequest
        bind_attribute :SiteID,   :site_id
        bind_attribute :SitePass, :site_pass
        bind_attribute :MemberID, :member_id
        bind_attribute :SeqMode,  :seq_mode
        bind_attribute :CardSeq,  :card_seq
      end

      class Response < GMO::PG::GenericResponse
        include ErrCodeAndErrInfo

        bind_attribute :CardSeq, :card_seq
      end
    end
  end
end
