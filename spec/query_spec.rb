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
