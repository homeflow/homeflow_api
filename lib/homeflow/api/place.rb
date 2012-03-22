module Homeflow
  module API
   class Place < Resource

    is_resource :places

    def self.disambiguate(disambiguation_phrase)
      Request.run_for(Homeflow::API::ResourceIdentifier.new("/places", :search => {:name => disambiguation_phrase}))
    end

   end
 end
end