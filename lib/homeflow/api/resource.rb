module Homeflow
  module API
   class Resource
      include Homeflow::API::Queryable
      include Hashie::Extensions::MethodQuery


      def initialize(hash = {})
        @data = hash
      end

      def [](key)
        k = key.to_s if !key.is_a?(String)
        v = @data[k]
        if v.kind_of?(Array)
          return v.map { |e| e.is_a?(::Hash) ? self.class.new(e) : e } 
        elsif v.kind_of?(Hash)
          return self.class.new(v)
        else
          return v
        end     
      end

      def []=(key, value)
        @data.send(:[]=, key.to_s, value)
      end

      def respond_to?(name, include_private = false)
        return true if has_key?(name)
        super
      end

      def has_key?(key)
        k = key.to_s if !key.is_a?(String)
        @data.has_key?(k)
      end
      
      def method_missing(name, *args)
        return self[name] if has_key?(name)
        return nil
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

