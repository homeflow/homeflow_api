module Homeflow
  module API
   class SitePage < Resource

    is_resource :site_pages

    def self.find_by_key_and_site_id(key, site_id)
    	Request.run_for(Homeflow::API::ResourceIdentifier.new("/sites/#{site_id}/pages/#{key}"))
    end

    def self.find_by_site_id(site_id)
    	Request.run_for(Homeflow::API::ResourceIdentifier.new("/sites/#{site_id}/pages"))
    end

   end
 end
end