module Homeflow
  module API
   class Resource
      include Homeflow::API::Queryable
      include Hashie::Extensions::MethodQuery


      def initialize(hash = {})
        @data = hash
      end

      def [](k)
        k = k.to_s if !k.is_a?(String)
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
        return true if @data.respond_to?(name, include_private)
        super
      end

      def has_key?(key)
        key = key.to_s if !key.is_a?(String)
        @data.has_key?(key)
      end
      
      def method_missing(name, *args)
        return self[name] if has_key?(name)
        if @data.respond_to?(name)
          @data.send(name, *args)
        else
          return nil
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

