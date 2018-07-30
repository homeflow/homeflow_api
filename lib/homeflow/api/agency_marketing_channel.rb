module Homeflow
  module API
    class AgencyMarketingChannel < Resource

      is_resource :agency_marketing_channels

      def self.find_by_agency_id(agency_id)
        Request.run_for(Homeflow::API::ResourceIdentifier.new("/agencies/#{agency_id}/agency_marketing_channels"))
      end

    end
  end
end
