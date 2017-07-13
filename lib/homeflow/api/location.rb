module Homeflow
  module API
   class Location < Resource

    is_resource :locations


    #returns a search object pre build withe the correct place id
    def properties
      Property.where(:place => {:id => place_id})
    end

    def self.find_by_county_id_and_location_id(county_id, location_id)
      Request.run_for(Homeflow::API::ResourceIdentifier.new("/counties/#{county_id}/locations/#{location_id}"))
    end

    def self.find_by_country_id_and_county_id_and_location_id(country_id, county_id, location_id)
      Request.run_for(Homeflow::API::ResourceIdentifier.new("/countries/#{country_id}/counties/#{county_id}/locations/#{location_id}"))
    end

   end
 end
end
