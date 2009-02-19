require File.dirname(__FILE__) + "/spec_helper"

describe Clockwork::Assertion do
  before :all do
    @date = Date.new(*DATE_ATTRIBUTES.map { |a| VALUES[a] })
    @datetime = DateTime.new(*DATETIME_ATTRS.map { |a| VALUES[a] })
    @time = Time.local(*TIME_ATTRIBUTES.map { |a| VALUES[a] })
    @values = { Date => @date, DateTime => @datetime, Time => @time }
  end

  describe "DAY_PRECISION_UNITS" do
    DAY_PRECISION_UNITS.each do |attr|
      value = VALUES[attr]
      random = rand(99)
      
      {::Time => true, ::DateTime => true, ::Date => true}.each do |klass, specific|
        it "should match #{klass} objects on asserted #{attr} integer value" do
          Clockwork::Assertion.new(attr, value).should === @values[klass]
        end
      
        it "should match #{klass} objects on asserted #{attr} range value" do
          Clockwork::Assertion.new(attr, (value - 1)..(value + 1)).should === @values[klass]
        end
      
        if specific
          it "should not match #{klass} objects on any other #{attr} value" do
            Clockwork::Assertion.new(attr, value - 1).should_not === @values[klass]
            Clockwork::Assertion.new(attr, value + 1).should_not === @values[klass]
            Clockwork::Assertion.new(attr, value + random).should_not === @values[klass]
          end
        else
          it "should match #{klass} objects on any other #{attr} value" do
            Clockwork::Assertion.new(attr, value - 1).should === @values[klass]
            Clockwork::Assertion.new(attr, value + 1).should === @values[klass]
            Clockwork::Assertion.new(attr, value + random).should === @values[klass]
          end
        end
      end
    end
  end # describe DAY_PRECISION_UNITS
  
  describe "SECOND_PRECISION_UNITS" do
    (SECOND_PRECISION_UNITS - DAY_PRECISION_UNITS).each do |attr|
      value = VALUES[attr]
      random = rand(99)
      
      {::Time => true, ::DateTime => true, ::Date => false}.each do |klass, specific|
        it "should match #{klass} objects on asserted #{attr} integer value" do
          Clockwork::Assertion.new(attr, value).should === @values[klass]
        end
      
        it "should match #{klass} objects on asserted #{attr} range value" do
          Clockwork::Assertion.new(attr, (value - 1)..(value + 1)).should === @values[klass]
        end
        
        if specific
          it "should not match #{klass} objects on any other #{attr} value" do
            Clockwork::Assertion.new(attr, value - 1).should_not === @values[klass]
            Clockwork::Assertion.new(attr, value + 1).should_not === @values[klass]
            Clockwork::Assertion.new(attr, value + random).should_not === @values[klass]
          end
        else
          it "should match #{klass} objects on any other #{attr} value" do
            Clockwork::Assertion.new(attr, value - 1).should === @values[klass]
            Clockwork::Assertion.new(attr, value + 1).should === @values[klass]
            Clockwork::Assertion.new(attr, value + random).should === @values[klass]
          end
        end
      end
    end
  end # describe SECOND_PRECISION_UNITS
  
  describe "USECOND_PRECISION_UNITS" do
    (USECOND_PRECISION_UNITS - SECOND_PRECISION_UNITS).each do |attr|
      value = VALUES[attr]
      random = rand(99)
      
      {::Time => true, ::DateTime => false, ::Date => false}.each do |klass, specific|
        it "should match #{klass} objects on asserted #{attr} integer value" do
          Clockwork::Assertion.new(attr, value).should === @values[klass]
        end
        
        it "should match #{klass} objects on asserted #{attr} range value" do
          Clockwork::Assertion.new(attr, (value - 1)..(value + 1)).should === @values[klass]
        end
        
        if specific
          it "should not match #{klass} objects on any other #{attr} value" do
            Clockwork::Assertion.new(attr, value - 1).should_not === @values[klass]
            Clockwork::Assertion.new(attr, value + 1).should_not === @values[klass]
            Clockwork::Assertion.new(attr, value + random).should_not === @values[klass]
          end
        else
          it "should match #{klass} objects on any other #{attr} value" do
            Clockwork::Assertion.new(attr, value - 1).should === @values[klass]
            Clockwork::Assertion.new(attr, value + 1).should === @values[klass]
            Clockwork::Assertion.new(attr, value + random).should === @values[klass]
          end
        end
      end
    end
  end
end
