require File.expand_path(File.join(File.dirname(__FILE__), %w[.. spec_helper]))

include Clockwork

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

      [::Time, ::DateTime, ::Date].each do |klass|
        it "should match #{klass} objects on asserted #{attr} integer value" do
          Assertion.new(attr, value).should === @values[klass]
        end

        it "should match #{klass} objects on asserted #{attr} range value" do
          Assertion.new(attr, (value - 1)..(value + 1)).should === @values[klass]
        end

        it "should not match #{klass} objects on any other #{attr} value" do
          Assertion.new(attr, value - 1).should_not === @values[klass]
          Assertion.new(attr, value + 1).should_not === @values[klass]
          Assertion.new(attr, value + random).should_not === @values[klass]
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
          Assertion.new(attr, value).should === @values[klass]
        end

        it "should match #{klass} objects on asserted #{attr} range value" do
          Assertion.new(attr, (value - 1)..(value + 1)).should === @values[klass]
        end

        if specific
          it "should not match #{klass} objects on any other #{attr} value" do
            Assertion.new(attr, value - 1).should_not === @values[klass]
            Assertion.new(attr, value + 1).should_not === @values[klass]
            Assertion.new(attr, value + random).should_not === @values[klass]
          end
        else
          it "should match #{klass} objects on any other #{attr} value" do
            Assertion.new(attr, value - 1).should === @values[klass]
            Assertion.new(attr, value + 1).should === @values[klass]
            Assertion.new(attr, value + random).should === @values[klass]
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
          Assertion.new(attr, value).should === @values[klass]
        end

        it "should match #{klass} objects on asserted #{attr} range value" do
          Assertion.new(attr, (value - 1)..(value + 1)).should === @values[klass]
        end

        if specific
          it "should not match #{klass} objects on any other #{attr} value" do
            Assertion.new(attr, value - 1).should_not === @values[klass]
            Assertion.new(attr, value + 1).should_not === @values[klass]
            Assertion.new(attr, value + random).should_not === @values[klass]
          end
        else
          it "should match #{klass} objects on any other #{attr} value" do
            Assertion.new(attr, value - 1).should === @values[klass]
            Assertion.new(attr, value + 1).should === @values[klass]
            Assertion.new(attr, value + random).should === @values[klass]
          end
        end
      end
    end
  end

  describe "#next_occurrences" do
    it "should return a single Time objects representing the next occurrence of the receiver" do
      assertion = Assertion.new(:mday, 1)
      assertion.next_occurrence(@time).should == Time.local(@time.year, @time.month + 1, 1, @time.hour, @time.min, @time.sec)
    end
  end
end
