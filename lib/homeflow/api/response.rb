module Homeflow

  module API
   class Response

    def self.new_from_json(json)
      begin
       hash = MultiJson.load(json)
      rescue MultiJson::LoadError
        raise Homeflow::API::Exceptions::InvalidResponse
      end
      raise Homeflow::API::Exceptions::InvalidResponse unless hash.is_a?(Hash)
      self.new(hash)
    end

    attr_accessor :query, :result, :response, :error


    COLLECTIONS_OBJECTS = {
      "password_reset" => Homeflow::API::PasswordReset,
      "properties" => Homeflow::API::Property,
      "search" => Homeflow::API::Search,
      "property" => Homeflow::API::Property,
      "county" => Homeflow::API::County,
      "location" => Homeflow::API::Location,
      "agency" => Homeflow::API::Agency,
      "agencies" => Homeflow::API::Agency,
      "article" => Homeflow::API::Article,
      "articles" => Homeflow::API::Article,
      "testimonial" => Homeflow::API::Testimonial,
      "testimonials" => Homeflow::API::Testimonial,
      "geo_feature" => Homeflow::API::GeoFeature,
      "geo_features" => Homeflow::API::GeoFeature,
      "locations" => Homeflow::API::Location,
      "node" => Homeflow::API::Node,
      "nodes" => Homeflow::API::Node,
      "counties" => Homeflow::API::County,
      "branch" => Homeflow::API::Branch,
      "branches" => Homeflow::API::Branch,
      "session" => Homeflow::API::Session,
      "portal" => Homeflow::API::Portal,
      'user' => Homeflow::API::User,
      'message' => Homeflow::API::Message,
      "lead" => Homeflow::API::Lead,
      "site_content_chunk" => Homeflow::API::SiteContentChunk,
      "site_content_chunks" => Homeflow::API::SiteContentChunk,
      "postcodes" => Homeflow::API::Postcode,
      "postcode" => Homeflow::API::Postcode,
      "site_page" => Homeflow::API::SitePage,
      "site_pages" => Homeflow::API::SitePage,
      "alternative_places" => {
        "locations" => Homeflow::API::Location,
        "counties" => Homeflow::API::County
      },
      "favourite_properties" => Homeflow::API::FavouriteProperty
    }

    def initialize(hash)
      @built_result_objects = {}
      @query = Hashie::Mash.new(hash["query"])
      @result =  build_result_objects(hash["result"])
      @response = Hashie::Mash.new(hash["response"])
      @error = Hashie::Mash.new(hash["error"])

      errors if error.type
    end

    def method_missing(method, *args, &block)
      if @built_result_objects.has_key?(method.to_s)
        @built_result_objects[method.to_s]
      else
        super
      end
    end


    def respond_to?(method, include_private = false)
      if @built_result_objects.has_key?(method.to_s)
        true
      else
        super
      end
    end

    protected

    def errors
      Homeflow::API::Exceptions::ExceptionsList.list.each do |a|
        if "Homeflow::API::Exceptions::#{error.type}" == a.name.to_s
          raise a, error.message
        end
      end
    end

    def build_result_objects(result)
      COLLECTIONS_OBJECTS.each do |key, o|
        if result.has_key?(key)
          if result[key].has_key?("elements")
            item = Collection.new(result[key], o)
          elsif o.is_a? Hash
            hash = {}
            o.each{|k,v| hash[k.to_sym] = Collection.new(result[key][k], v) if result[key][k]  }
            item = Hashie::Mash.new(hash)
          else
            item = o.new(result[key])
          end
        end

        @built_result_objects[key] = item if item
        item = nil
      end
      return result
    end


   end
 end
end
