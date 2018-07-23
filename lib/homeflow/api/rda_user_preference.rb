module Homeflow
  module API
    class RdaUserPreference < Resource

      is_resource :rda_user_preferences

      def self.find_by_user_id(user_id)
        Request.run_for(Homeflow::API::ResourceIdentifier.new("/users/#{user_id}/rda_user_preference"))
      end

    end
  end
end
