module Homeflow
  module API
  YAML::ENGINE.yamler= 'syck' if defined?(YAML::ENGINE)
   class Request

    include HTTParty


    attr_accessor :resource_class, :request_specification

    def initialize(request_specification)
      @request_specification = request_specification
    end

    def perform
      begin
        response = body_of_request(perform_request)
      rescue Errno::ECONNREFUSED => e
        raise Homeflow::API::Exceptions::APIConnectionError, "Homeflow might be down? Connection error: #{e}"
      end
      response
    end

    def perform_request
      url = normalised_base_url
      query_params = @request_specification.to_params.merge(constant_params)
      post_params = (@request_specification.respond_to?(:post_params) ? @request_specification.post_params : {})
      if Homeflow::API.config.show_debug && Homeflow::API.configuration.logger
        log_line = []
        log_line << "Destination - #{url}"
        log_line << "Request params:\n#{query_params.to_json}\n"
        log_line << "Post params:\n#{post_params.to_json}\n"
        log_line << "request_specification:\n#{request_specification.to_json}\n"
        log_line << "@request_specification:\n#{@request_specification.to_json}\n"
        Homeflow::API.configuration.logger.info(log_line.join("\n"))
      end

      if request_specification.is_a? Query
        return (self.class.get(url, :query => query_params))
      elsif request_specification.is_a? ResourceIdentifier
        return (self.class.get(url, :query => query_params))
      elsif request_specification.is_a? Delete
        return (self.class.delete(url, :query => query_params))
      elsif request_specification.is_a? Put
        return (self.class.put(url, :query => query_params, :body => post_params))
      elsif request_specification.is_a? Post
        return (self.class.post(url, :query => query_params, :body => post_params))
      end
    end

    def normalised_base_url
      source = Homeflow::API.config.source.chomp('/')
      if request_specification.is_a? Query
        if source_athena && is_resource?('site_content_chunks')
          source = source_athena
        elsif source_properties && is_resource?('properties')
          source = source_properties
        elsif source_places && is_place_based_resource?
          source = source_places
        end
        return "#{source}/#{request_specification.resource_class.resource_uri}"
      else
        if source_places && ["locations", "postcodes", "places", "counties"].map{|i| request_specification.resource_uri.include?(i)}.include?(true)
          source = source_places
        elsif source_properties && (request_specification.resource_uri.include?('properties'))
          source = source_properties
        end
        return "#{source}/#{request_specification.resource_uri}"
      end
    end

    def _source(source_id)
      return nil if Homeflow::API.config.send("source_#{source_id}").blank?
      Homeflow::API.config.send("source_#{source_id}").chomp('/')
    end

    def source_athena
      _source('athena')
    end

    def source_places
      _source('places')
    end

    def source_properties
      _source('properties')
    end

    def is_place_based_resource?
      is_resource?('places') || is_resource?('locations') || is_resource?('postcodes') || is_resource?('counties')
    end

    def is_resource?(resource_id)
      request_specification.resource_class.resource_uri == resource_id
    end

    def body_of_request(request)
      if request.respond_to? :body
        request.body
      else
        request
      end
    end


    def constant_params
      {
        :api_key     => Homeflow::API.config.api_key,
        :request_key => Homeflow::API.config.request_key
      }
    end

    class << self
      def run_for(request_specification)
        r = Request.new(request_specification)
        r = r.perform
        if r.is_a? Hash
          Response.new(r)
        else
          Response.new_from_json(r)
        end
      end
    end

   end
  end
end
