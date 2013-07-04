module Homeflow
  module API
   YAML::ENGINE.yamler = "syck"
   class Request

    attr_accessor :resource_class, :request_specification

    def initialize(request_specification)
      @request_specification = request_specification
    end

    def perform
      begin
        response = perform_request
      rescue Errno::ECONNREFUSED => e
        raise Homeflow::API::Exceptions::APIConnectionError, "Connection error. Homeflow might be down?"
      end
      response
    end

    def perform_request
      if request_specification.is_a? Query
        url = "#{Homeflow::API.config.source}/#{request_specification.resource_class.resource_uri}"
      else
        url = "#{Homeflow::API.config.source}/#{request_specification.resource_uri}"
      end
      query_params = @request_specification.to_params.merge(constant_params)
      post_params = (@request_specification.respond_to?(:post_params) ? @request_specification.post_params : {})
      if Homeflow::API.config.show_debug
        puts "****************************************************************************************"
        puts "HESTIA CALL"
        puts "==========="
        puts "Destination" - url
        puts "Request params:\n#{query_params.to_json}\n"
        puts "Post params:\n#{post_params.to_json}\n"
        puts "request_specification:\n#{request_specification.to_json}\n"
        puts "@request_specification:\n#{@request_specification.to_json}\n"
        puts "****************************************************************************************"
      end

      if request_specification.is_a? Query
        return (HTTParty.get(url, :query => query_params)).body
      elsif request_specification.is_a? ResourceIdentifier
        return (HTTParty.get(url, :query => query_params)).body
      elsif request_specification.is_a? Delete
        return (HTTParty.delete(url, :query => query_params)).body
      elsif request_specification.is_a? Put
        return (HTTParty.put(url, :query => query_params, :body => post_params)).body
      elsif request_specification.is_a? Post
        return (HTTParty.pos(url, :query => query_params, :body => post_params)).body
      end
    end


    def constant_params
      {:api_key=> Homeflow::API.config.api_key}
    end

    class << self
      def run_for(request_specification)
        r = Request.new(request_specification)
        Response.new_from_json(r.perform)
      end
    end
    
   end
  end
end
