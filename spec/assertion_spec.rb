require File.dirname(__FILE__) + "/spec_helper"

describe Clockwork::Assertion do
  DATE_ATTRIBUTES = [:year, :month, :mday]
  DATETIME_ATTRS  = DATE_ATTRIBUTES + [:hour, :min, :sec]
  TIME_ATTRIBUTES = DATETIME_ATTRS + [:usec]
  
  DERIVED_ATTRS = [:yday, :wday]
  DAY_PRECISION_UNITS     = DATE_ATTRIBUTES + DERIVED_ATTRS
  SECOND_PRECISION_UNITS  = DATETIME_ATTRS + DERIVED_ATTRS
  USECOND_PRECISION_UNITS = TIME_ATTRIBUTES + DERIVED_ATTRS
  
  # Wed Sep 24 18:30:15 -0700 2008, 500 usec
  VALUES = {
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
    @time = Time.local(*TIME_ATTRIBUTES.map { |a| VALUES[a] })
    @datetime = DateTime.new(*DATETIME_ATTRS.map { |a| VALUES[a] })
    @date = Date.new(*DATE_ATTRIBUTES.map { |a| VALUES[a] })
  end
  
  describe "DAY_PRECISION_UNITS" do
    DAY_PRECISION_UNITS.each do |attr|
      value = VALUES[attr]
      random = rand(99)
      
      it "should match Time objects on asserted #{attr} integer value" do
        Clockwork::Assertion.new(attr, value).should === @time
      end
      
      it "should match Date objects on asserted #{attr} integer value" do
        Clockwork::Assertion.new(attr, value).should === @date
      end
      
      it "should match DateTime objects on asserted #{attr} integer value" do
        Clockwork::Assertion.new(attr, value).should === @datetime
      end
      
      it "should match Time objects on asserted #{attr} range value" do
        Clockwork::Assertion.new(attr, (value - 1)..(value + 1)).should === @time
      end
      
      it "should match Date objects on asserted #{attr} range value" do
        Clockwork::Assertion.new(attr, (value - 1)..(value + 1)).should === @date
      end
      
      it "should match DateTime objects on asserted #{attr} range value" do
        Clockwork::Assertion.new(attr, (value - 1)..(value + 1)).should === @datetime
      end
      
      it "should not match Time objects on any other #{attr} value" do
        Clockwork::Assertion.new(attr, value - 1).should_not === @time
        Clockwork::Assertion.new(attr, value + 1).should_not === @time
        Clockwork::Assertion.new(attr, value + random).should_not === @time
      end
      
      it "should not match Date objects on any other #{attr} value" do
        Clockwork::Assertion.new(attr, value - 1).should_not === @date
        Clockwork::Assertion.new(attr, value + 1).should_not === @date
        Clockwork::Assertion.new(attr, value + random).should_not === @date
      end
      
      it "should not match DateTime objects on any other #{attr} value" do
        Clockwork::Assertion.new(attr, value - 1).should_not === @datetime
        Clockwork::Assertion.new(attr, value + 1).should_not === @datetime
        Clockwork::Assertion.new(attr, value + random).should_not === @datetime
      end
    end
  end # describe DAY_PRECISION_UNITS
  
  describe "SECOND_PRECISION_UNITS" do
    (SECOND_PRECISION_UNITS - DAY_PRECISION_UNITS).each do |attr|
      value = VALUES[attr]
      random = rand(99)
      
      it "should match Time objects on asserted #{attr} integer value" do
        Clockwork::Assertion.new(attr, value).should === @time
      end
      
      it "should match DateTime objects on asserted #{attr} integer value" do
        Clockwork::Assertion.new(attr, value).should === @datetime
      end
      
      it "should match Date objects on asserted #{attr} integer value" do
        Clockwork::Assertion.new(attr, value).should === @date
      end
      
      it "should match Time objects on asserted #{attr} range value" do
        Clockwork::Assertion.new(attr, (value - 1)..(value + 1)).should === @time
      end
      
      it "should match DateTime objects on asserted #{attr} range value" do
        Clockwork::Assertion.new(attr, (value - 1)..(value + 1)).should === @datetime
      end
      
      it "should match Date objects on asserted #{attr} range value" do
        Clockwork::Assertion.new(attr, (value - 1)..(value + 1)).should === @date
      end
      
      it "should not match Time objects on any other #{attr} value" do
        Clockwork::Assertion.new(attr, value - 1).should_not === @time
        Clockwork::Assertion.new(attr, value + 1).should_not === @time
        Clockwork::Assertion.new(attr, value + random).should_not === @time
      end
      
      it "should not match DateTime objects on any other #{attr} value" do
        Clockwork::Assertion.new(attr, value - 1).should_not === @datetime
        Clockwork::Assertion.new(attr, value + 1).should_not === @datetime
        Clockwork::Assertion.new(attr, value + random).should_not === @datetime
      end
      
      it "should match Date objects on any other #{attr} value" do
        Clockwork::Assertion.new(attr, value - 1).should === @date
        Clockwork::Assertion.new(attr, value + 1).should === @date
        Clockwork::Assertion.new(attr, value + random).should === @date
      end
    end
  end # describe SECOND_PRECISION_UNITS
  
  describe "USECOND_PRECISION_UNITS" do
    (USECOND_PRECISION_UNITS - SECOND_PRECISION_UNITS).each do |attr|
      value = VALUES[attr]
      random = rand(99)
      
      it "should match Time objects on asserted #{attr} integer value" do
        Clockwork::Assertion.new(attr, value).should === @time
      end
      
      it "should match DateTime objects on asserted #{attr} integer value" do
        Clockwork::Assertion.new(attr, value).should === @datetime
      end
      
      it "should match Date objects on asserted #{attr} integer value" do
        Clockwork::Assertion.new(attr, value).should === @date
      end
      
      it "should match Time objects on asserted #{attr} range value" do
        Clockwork::Assertion.new(attr, (value - 1)..(value + 1)).should === @time
      end
      
      it "should match DateTime objects on asserted #{attr} range value" do
        Clockwork::Assertion.new(attr, (value - 1)..(value + 1)).should === @datetime
      end
      
      it "should match Date objects on asserted #{attr} range value" do
        Clockwork::Assertion.new(attr, (value - 1)..(value + 1)).should === @date
      end
      
      it "should not match Time objects on any other #{attr} value" do
        Clockwork::Assertion.new(attr, value - 1).should_not === @time
        Clockwork::Assertion.new(attr, value + 1).should_not === @time
        Clockwork::Assertion.new(attr, value + random).should_not === @time
      end
      
      it "should match DateTime objects on any other #{attr} value" do
        Clockwork::Assertion.new(attr, value - 1).should === @datetime
        Clockwork::Assertion.new(attr, value + 1).should === @datetime
        Clockwork::Assertion.new(attr, value + random).should === @datetime
      end
      
      it "should match Date objects on any other #{attr} value" do
        Clockwork::Assertion.new(attr, value - 1).should === @date
        Clockwork::Assertion.new(attr, value + 1).should === @date
        Clockwork::Assertion.new(attr, value + random).should === @date
      end
    end
  end
end
