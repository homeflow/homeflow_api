module Homeflow
  module API
   class Resource < Hash
      include Homeflow::API::Queryable
      include Hashie::Extensions::IndifferentAccess
      include Hashie::Extensions::MethodAccess


      def initialize(hash = {})
        hash.each_pair do |k,v|
          if v.kind_of?(Array)
            self[k] = v.map { |e| e.is_a?(::Hash) ? self.new(e) : e }
          else
            self[k] = v
          end
        end
      end

      class << self

        def is_resource(uri)
          @resource_uri = uri.to_s
        end

        def find(id, params = {})
          Request.run_for(Homeflow::API::ResourceIdentifier.new("/#{resource_uri}/#{id}", params))
        end

        def delete(id, params = {})
         Request.run_for(Homeflow::API::Delete.new("/#{resource_uri}/#{id}", params))
        end

        def resource_uri
          @resource_uri
        end

      end
   end
  end
end

