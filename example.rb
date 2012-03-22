require 'rubygems'
require 'homeflow/api'

Homeflow::API.configure do |config|
  config.api_key = "7ea9bbb0771dd16679d20c9b27a0e97c"
  config.source = "http://localhost:8081"
end

  #Homeflow::API::Property.find

#k = Homeflow::API::Property.where(:channel => :sales, :query => 'bexley').options(:include_count => true).page(5).fields(:short_description, :lat, :lng, :photos).results



k =  Homeflow::API::Place.disambiguate('brighton')

puts k.locations

#



