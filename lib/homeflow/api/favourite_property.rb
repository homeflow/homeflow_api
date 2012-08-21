module Homeflow
  module API
   class FavouriteProperty < Resource

    is_resource :favourite_properties

   	def self.create(params)
      Request.run_for(Homeflow::API::Post.new("/#{resource_uri}/", {}, params))
    end

   end
 end
end