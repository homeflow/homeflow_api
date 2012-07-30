#This module contains class methods used when building up querys on resources. Think index?
module Homeflow
  module API
   class ResourceIdentifier < RequestSpecification

    attr_accessor :resource_uri

    def initialize(resource_uri, params = {})
      @resource_uri = resource_uri
      @params = params
    end

    def to_params
      @params.merge(@params) { |name, values| values.is_a?(Array) ? values.join(',') : values }
    end

   end
  end
end
