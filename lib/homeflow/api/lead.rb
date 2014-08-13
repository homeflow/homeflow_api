module Homeflow
  module API
   class Lead < Resource

    is_resource :leads

    def self.create(params)
      Request.run_for(Homeflow::API::Post.new("/#{resource_uri}/", {}, params))
    end

   end
 end
end