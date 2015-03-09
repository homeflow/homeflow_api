module Homeflow
  module API
   class Node < Resource

    is_resource :nodes

    def self.find_by_key_and_site_id(key, site_id)
    	Request.run_for(Homeflow::API::ResourceIdentifier.new("/sites/#{site_id}/nodes/#{key}"))
    end

    def self.find_by_site_id(site_id)
    	Request.run_for(Homeflow::API::ResourceIdentifier.new("/sites/#{site_id}/nodes"))
    end

   end
 end
end
