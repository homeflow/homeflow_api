module Homeflow
  module API
   class Article < Resource

    is_resource :articles

    def self.find_by_site_id_and_article_id(site_id, article_id)
      Request.run_for(Homeflow::API::ResourceIdentifier.new("/sites/#{site_id}/articles/#{article_id}"))
    end

   end
 end
end
