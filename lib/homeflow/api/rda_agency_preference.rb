module Homeflow
  module API
    class RdaAgencyPreference < Resource

      is_resource :rda_agency_preferences

      def self.find_by_agency_id(agency_id)
        Request.run_for(Homeflow::API::ResourceIdentifier.new("/rda_agency_preferences/#{agency_id}"))
      end

    end
  end
end
