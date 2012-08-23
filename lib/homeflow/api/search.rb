module Homeflow
  module API
   class Search < Resource

    is_resource :searches

    def self.create(params)
      Request.run_for(Homeflow::API::Post.new("/#{resource_uri}/", {}, params))
    end


   end
 end
end