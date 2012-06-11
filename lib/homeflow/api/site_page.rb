module Homeflow
  module API
   class SitePage < Resource

    is_resource :site_pages

    def find(id, site_id)
    	Request.run_for(Homeflow::API::ResourceIdentifier.new("/sites/#{site_id}/pages/#{id}"))
    end

   end
 end
end