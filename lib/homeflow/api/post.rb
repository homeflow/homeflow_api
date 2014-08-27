#This module contains class methods used when building up querys on resources. Think index?
module Homeflow
  module API
   class Post < RequestSpecification

    attr_accessor :resource_uri

    def initialize(resource_uri, params = {}, post_params = {})
      @resource_uri = resource_uri
      @params = params
      @post_params = post_params
    end

    def post_params
      @post_params
    end

    def to_params
      @params
    end

   end
  end
end