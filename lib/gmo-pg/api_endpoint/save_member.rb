module GMO
  module PG
    module SaveMember
      extend APIEndpoint

      class Request < GMO::PG::GenericRequest
        bind_attribute :SiteID,     :site_id
        bind_attribute :SitePass,   :site_pass
        bind_attribute :MemberID,   :member_id
        bind_attribute :MemberName, :member_name
      end

      class Response < GMO::PG::GenericResponse
        include ErrCodeAndErrInfo

        bind_attribute :MemberID, :member_id
      end
    end
  end
end
