module Homeflow
  module API
   class SitePage < Resource

    is_resource :site_pages

    def find_by_key_and_site_id(key, site_id)
    	Request.run_for(Homeflow::API::ResourceIdentifier.new("/sites/#{site_id}/pages/#{key}"))
    end

   end
 end
end