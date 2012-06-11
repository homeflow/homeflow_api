module Homeflow
  module API
   class Session < Resource

    is_resource :sessions

    def self.create(params)
      Request.run_for(Homeflow::API::Post.new("/#{resource_uri}/", {}, params))
    end

   end
 end
end