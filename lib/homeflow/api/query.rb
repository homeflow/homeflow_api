#This module contains class methods used when building up querys on resources. Think index?
module Homeflow
  module API
   class Query < RequestSpecification

    attr_accessor :resource_class, :query, :fields, :page, :page_size

    def initialize(resource_class, params)
      @resource_class = resource_class
      @fields = []
      @options = {}
      @page_size = nil
      @page =  1
      search,fields = nil
      add_search(search) if search = params.delete(:query)
      set_fields(fields) if fields = params.delete(:fields)
    end

    def page_size(page_size)
      @page_size = page_size
      self
    end

    def page(page)
      @page = page
      self
    end

    def where(search_hash)
      add_search(search_hash)
      self
    end

    def options(options_hash)
      @options.merge!(options_hash)
      self
    end

    def fields(*args)
      set_fields(args)
      self
    end

    def add_search(search_hash)
      @query ||= {}
      @query.merge!(search_hash)
    end

    def set_fields(fields_array)
      @fields = fields_array
    end

    def results
      @_results ||= results!
    end

    def results!
      @_results = @resource_class.execute(self)
    end

    def response
      results
    end

    def each(&block)
      r = results.send(resource_class.resource_uri)
      r.each {|k|
        case block.arity
          when 1
            yield k
          when 2
            yield k, results
        end
      }
    end

    def to_params
      options = {}
      options =  options.merge({:page_size => @page_size}) unless @page_size.nil?
      options = options.merge({:search => @query, :fields => @fields.join(','), :search_options => @options, :page=> @page})
    end

   end
  end
end