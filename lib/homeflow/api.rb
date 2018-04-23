require 'hashie/mash'
require 'json'
require 'httparty'

current_dir = File.expand_path(File.dirname(__FILE__))

require current_dir + "/api/request"
require current_dir + "/api/queryable"
require current_dir + "/api/resource"
require current_dir + "/api/collection"
require current_dir + "/api/request_specification"
require current_dir + "/api/resource_identifier"
require current_dir + "/api/post"
require current_dir + "/api/put"
require current_dir + "/api/delete"
require current_dir + "/api/query"
require current_dir + "/api/exceptions"
require current_dir + "/api/agency_employee"
require current_dir + "/api/article"
require current_dir + "/api/testimonial"
require current_dir + "/api/geo_feature"
require current_dir + "/api/local_business_datum"
require current_dir + "/api/agency_local_business_datum"
require current_dir + "/api/menu_item"
require current_dir + "/api/search"
require current_dir + "/api/property"
require current_dir + "/api/county"
require current_dir + "/api/country"
require current_dir + "/api/location"
require current_dir + "/api/place"
require current_dir + "/api/site_content_chunk"
require current_dir + "/api/agency"
require current_dir + "/api/password_reset"
require current_dir + "/api/branch"
require current_dir + "/api/user"
require current_dir + "/api/session"
require current_dir + "/api/lead"
require current_dir + "/api/portal"
require current_dir + "/api/postcode"
require current_dir + "/api/site"
require current_dir + '/api/site_page'
require current_dir + '/api/node'
require current_dir + '/api/message'
require current_dir + "/api/favourite_property"
require current_dir + "/api/rda_agency_preference"
require current_dir + "/api/response"

module Homeflow
  module API

    class << self
      attr_accessor :configuration
    end

    # Gets or create a new configuration instance
    def self.config
      self.configuration ||= Configuration.new
    end

    # Provides a block allowing for eacy configuration
    # ==== Examples
    #   Homeflow::API.configure do |config|
    #      config.api_key = "Your api key here"
    #   end
    #
    def self.configure
      yield(config)
    end

    # A configuration instance
    class Configuration
      attr_accessor :api_key, :source, :source_athena, :source_places, :source_properties, :show_debug, :logger, :request_key

      def initialize
        @request_key = ''
        @api_key = 'API_KEY_REQUIRED'
        @source = 'http://localhost:3000'
        @source_athena = ''
        @source_places = ''
        @source_properties = ''
        @show_debug = false
        @logger = nil
      end
    end

  end
end
