module GMO
  module PG
    module SearchMember
      extend APIEndpoint

      class Request < GMO::PG::GenericRequest
        bind_attribute :SiteID,   :site_id
        bind_attribute :SitePass, :site_pass
        bind_attribute :MemberID, :member_id
      end

      class Response < GMO::PG::GenericResponse
        bind_attribute :MemberID,   :member_id
        bind_attribute :MemberName, :member_name
        bind_attribute :DeleteFlag, :delete_flag
      end
    end
  end
end
