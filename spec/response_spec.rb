require 'spec_helper'

describe Homeflow::API::Response do
  context "A Respose Object" do
    it "should raise an exeption when given an invalid response" do
      error = %~<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0//EN">
        <HTML>
          <HEAD><TITLE>Internal Server Error</TITLE></HEAD>
          <BODY>
            <H1>Internal Server Error</H1>
            undefined method `debug_rjs=' for ActionView::Base:Class
            <HR>
            <ADDRESS>
             WEBrick/1.3.1 (Ruby/1.9.3/2011-10-30) at
             localhost:3000
            </ADDRESS>
          </BODY>
        </HTML>
         %~
      expect {Homeflow::API::Response.new_from_json(error)}.to raise_error(Homeflow::API::Exceptions::InvalidResponse)
    end


    it "should correctly produce alturnative locations" do
      file = File.read(File.dirname(__FILE__) + '/data/with_alt_places.json')
      response =  Homeflow::API::Response.new_from_json(file)
      response.respond_to?(:alternative_places).should == true
    end

    it "should raise the correct error when the wrong api key is given, with a message" do
      file = File.read(File.dirname(__FILE__) + '/data/invalid_api_key.json')
      expect {Homeflow::API::Response.new_from_json(file)}.to raise_error(Homeflow::API::Exceptions::APIArgumentError)
    end


    it "should be able to be created from a homeflow api response" do
      file = File.read(File.dirname(__FILE__) + '/data/example_search_response.json')
      response = Homeflow::API::Response.new_from_json(file)
      response.respond_to?(:properties).should == true
      response.properties.is_a?(Homeflow::API::Collection).should == true
      response.respond_to?(:alternative_places).should == false
      response.properties.first.is_a?(Homeflow::API::Property).should == true
    end

  end
end