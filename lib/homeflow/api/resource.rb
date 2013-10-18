module Homeflow
  module API
   class Resource < Hash
      include Homeflow::API::Queryable
      include Hashie::Extensions::MethodQuery


      def initialize(hash = {})
        hash.each_pair do |k,v|
          if v.kind_of?(Array)
            self[k.to_sym] = v.map { |e| e.is_a?(::Hash) ? self.class.new(e) : e } 
          elsif v.kind_of?(Hash)
            self[k.to_sym] = self.class.new(v)
          else
            self[k.to_sym] = v
          end
        end
      end

      def [](key)
        key = key.to_sym if key.is_a? String
        super(key)
      end

      def []=(key, value)
        key = key.to_sym if key.is_a? String
        super(key, value)
      end

      def respond_to?(name, include_private = false)
        return true if key?(name.to_sym)
        super
      end

      def has_key?(key)
        key = key.to_sym if key.is_a? String
        super(key)
      end
      
      def method_missing(name, *args)
        return self[name.to_sym] if key?(name.to_sym)
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

