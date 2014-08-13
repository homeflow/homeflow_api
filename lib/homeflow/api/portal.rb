module Homeflow
  module API
   class Portal < Resource

    is_resource :portal

    def self.find()
      Request.run_for(Homeflow::API::ResourceIdentifier.new("/#{resource_uri}/"))
    end

   end
 end
end