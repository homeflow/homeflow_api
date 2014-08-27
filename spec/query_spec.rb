require 'spec_helper'

describe Homeflow::API::Queryable do
  context "When used by a class" do

    it "should provide a where method generating a query" do
      query =  Homeflow::API::Property.where(:test => :argument)
      query.class.should == Homeflow::API::Query
      query.query.should == {:test => :argument}
    end

    it "should cause the implementing class to recive a message on execute" do
      query =  Homeflow::API::Property.where(:test => :argument)
      Homeflow::API::Property.should_receive(:execute).with(query)
      query.results
    end

  end
end


describe Homeflow::API::Resource do
  context "When inhereted by a class" do

    it "should cause the implementing class to recive a message when find is called" do
      data = File.read(File.dirname(__FILE__) + '/data/property_details.json')
      Homeflow::API::Request.any_instance.should_receive(:perform).and_return(data)
      property =  Homeflow::API::Property.find(2).property
      property.class.should == Homeflow::API::Property
    end


     it "should provide uri" do
      Homeflow::API::Property.resource_uri.should == 'properties'
    end

  end
end
