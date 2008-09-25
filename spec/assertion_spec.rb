require File.dirname(__FILE__) + "/spec_helper"

describe Clockwork::Assertion do
  TIME_ATTRS = [:year, :month, :mday, :hour, :min, :sec, :usec]
  DATE_ATTRS = TIME_ATTRS - [:hour, :min, :sec, :usec]
  
  ATTRIBUTES = {
    :year  => 2008,
    :month => 9,
    :mday  => 24,
    :hour  => 18,
    :min   => 30,
    :sec   => 15,
    :usec  => 500,
    :yday  => 268,
    :yweek => 3,
    :wday  => 3,
  }
  
  before :all do
    @time = Time.local(*TIME_ATTRS.map { |a| ATTRIBUTES[a] })
    @date = Date.new(*DATE_ATTRS.map { |a| ATTRIBUTES[a] })
  end
  
  ATTRIBUTES.each do |attribute, value|
    it "should match Time objects on asserted #{attribute} integer value" do
      Clockwork::Assertion.new(attribute, value).should === @time
    end
    
    it "should match Date objects on asserted #{attribute} integer value" do
      Clockwork::Assertion.new(attribute, value).should === @date
    end
    
    it "should match Time objects on asserted #{attribute} range value" do
      Clockwork::Assertion.new(attribute, (value - 1)..(value + 1)).should === @time
    end
    
    it "should match Date objects on asserted #{attribute} range value" do
      Clockwork::Assertion.new(attribute, (value - 1)..(value + 1)).should === @date
    end
    
    it "should not match Time objects on any other #{attribute} value" do
      Clockwork::Assertion.new(attribute, value - 1).should_not === @time
      Clockwork::Assertion.new(attribute, value + 1).should_not === @time
      Clockwork::Assertion.new(attribute, value + rand(999)).should_not === @time
    end
    
    it "should not match Date objects on any other #{attribute} value" do
      Clockwork::Assertion.new(attribute, value - 1).should_not === @date
      Clockwork::Assertion.new(attribute, value + 1).should_not === @date
      Clockwork::Assertion.new(attribute, value + rand(999)).should_not === @date
    end
  end
end
