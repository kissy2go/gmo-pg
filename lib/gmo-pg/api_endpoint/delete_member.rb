module GMO
  module PG
    module DeleteMember
      extend APIEndpoint

      class Request < GMO::PG::GenericRequest
        bind_attribute :SiteID,   :site_id
        bind_attribute :SitePass, :site_pass
        bind_attribute :MemberID, :member_id
      end

      class Response < GMO::PG::GenericResponse
        bind_attribute :MemberID, :member_id
      end
    end
  end
end
