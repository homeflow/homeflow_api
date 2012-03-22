module Homeflow
  module API
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
        return (HTTParty.get("#{Homeflow::API.config.source}/#{request_specification.resource_class.resource_uri}", :query => @request_specification.to_params.merge(constant_params))).body
      elsif request_specification.is_a? ResourceIdentifier
        return (HTTParty.get("#{Homeflow::API.config.source}/#{request_specification.resource_uri}", :query => @request_specification.to_params.merge(constant_params))).body
      elsif request_specification.is_a? Post
        return (HTTParty.post("#{Homeflow::API.config.source}/#{request_specification.resource_uri}", :query => @request_specification.to_params.merge(constant_params), :body => @request_specification.post_params)).body
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
