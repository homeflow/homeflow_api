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
        raise Homeflow::API::Exceptions::APIConnectionError, "Connection error. Homeflow might be down?"
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
      source = Homeflow::API.config.source.gsub(/.\/$/,'')
      if request_specification.is_a? Query
        if Homeflow::API.config.source_athena != '' && request_specification.resource_class.resource_uri == 'site_content_chunks'
          source = Homeflow::API.config.source_athena.gsub(/.\/$/,'')
        end
        return "#{source}/#{request_specification.resource_class.resource_uri}"
      else
        return "#{source}/#{request_specification.resource_uri}"
      end
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
