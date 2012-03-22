#This module contains class methods used when building up querys on resources. Think index?
module Homeflow
  module API
   class Collection < Array

      def initialize(collection_response, klass)
      	@has_next_page = collection_response["has_next"]
      	@total = collection_response["total"]
         collection_response["elements"].each{|element| self << klass.new(element)}
      end
      

      def has_next_page?
      	@has_next_page
      end

      def total
      	@total
      end
   end
  end
end