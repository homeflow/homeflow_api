module Homeflow
  module API
   class User < Resource

    is_resource :users

    def self.find(id, session_id, agency_id=nil)
      Request.run_for(Homeflow::API::ResourceIdentifier.new("/#{resource_uri}/#{id}", :session_id => session_id, :agency_id => agency_id))
    end

    def self.create(params)
      Request.run_for(Homeflow::API::Post.new("/#{resource_uri}/", {}, params))
    end

   end
 end
end