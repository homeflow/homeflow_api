module Homeflow
  module API
   class Resource < ::Hashie::Mash
      include Homeflow::API::Queryable

      class << self

        def is_resource(uri)
          @resource_uri = uri.to_s
        end

        def find(id)
          Request.run_for(Homeflow::API::ResourceIdentifier.new("/#{resource_uri}/#{id}"))
        end

        def resource_uri
          @resource_uri
        end

      end
   end
  end
end