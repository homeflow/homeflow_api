module Homeflow
  module API
   class User < Resource

    is_resource :users

    def self.find(id, session_id)
      Request.run_for(Homeflow::API::ResourceIdentifier.new("/#{resource_uri}/#{id}", :session_id => session_id))
    end

   end
 end
end