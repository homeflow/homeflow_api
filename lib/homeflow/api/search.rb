module Homeflow
  module API
   class Search < Resource

    is_resource :searches

    def self.create(params)
      Request.run_for(Homeflow::API::Post.new("/#{resource_uri}/", {}, params))
    end

    def self.update(id, params)
    	Request.run_for(Homeflow::API::Put.new("/#{resource_uri}/#{id}", {}, params))
    end

   end
 end
end