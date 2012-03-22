require 'spec_helper'
describe Homeflow::API do

  context "when setting up" do

    it "should provide a config block" do

      Homeflow::API.configure do |config|
        config.api_key = "test api key"
      end

      Homeflow::API.configuration.api_key.should == "test api key"

    end

    it "should provide setters" do
       Homeflow::API.configuration.api_key = "test api key"
       Homeflow::API.configuration.api_key.should == "test api key"
    end

  end
end