#All 'queryies' go in search[x]
module Homeflow
  module API
	 module Queryable

    def self.included(c)
      c.extend ClassMethods
    end
   

    module ClassMethods
      def where(query_hash)
        Homeflow::API::Query.new(self, :query => query_hash)
      end

      def fields(*args)
        Homeflow::API::Query.new(self, :fields => args)
      end

      def execute(query)
        Request.run_for(query)
      end

    end
	 end
  end
end