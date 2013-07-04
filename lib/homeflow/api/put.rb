#This module contains class methods used when building up querys on resources. Think index?
module Homeflow
  module API
   class Put < Post

    attr_accessor :resource_uri

    def initialize(resource_uri, params = {}, put_params = {})
      @resource_uri = resource_uri
      @params = params
      @put_params = put_params
    end

    def post_params
      @put_params
    end

    def to_params
      @params
    end

   end
  end
end