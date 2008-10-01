require File.dirname(__FILE__) + "/spec_helper"

describe Clockwork::Dsl do
  describe "arity one attribute assertions (ASSERTABLE_ATTRIBUTES)" do
    VALUES.each do |attribute, value|
      it "should return a[n] :#{attribute} Assertion when Dsl.#{attribute} is called" do
        assertion = Clockwork::Dsl.send(attribute, value)
        assertion.class.should     == Clockwork::Assertion
        assertion.attribute.should == attribute
        assertion.value.should     == value
      end
    end
  end
  
  describe "weekdays shortcuts (WEEKDAYS)" do
    Clockwork::Dsl::WEEKDAYS.each_with_index do |weekday, index|
      value = index
      
      it "should return a :wday Assertion with value #{value} when Dsl.#{weekday} is called" do
        assertion = Clockwork::Dsl.send(weekday)
        assertion.class.should     == Clockwork::Assertion
        assertion.attribute.should == :wday
        assertion.value.should     == value
      end
      
      it "should return a :wday Assertion with value #{value} when Dsl.#{weekday}s is called" do
        assertion = Clockwork::Dsl.send("#{weekday}s")
        assertion.class.should     == Clockwork::Assertion
        assertion.attribute.should == :wday
        assertion.value.should     == value
      end
      
      it "should accept an Integer argument which defines an intersecting :wday_in_month Assertion" do
        assertion = Clockwork::Dsl.send(weekday, 1)
        assertion.class.should      == Clockwork::Intersection
        assertion.attributes.should == [:wday, :wday_in_month]
        assertion.values.should     == [index, 1]
      end
      
      it "should accept a Symbol argument which defines an intersecting :wday_in_month Assertion" do
        assertion = Clockwork::Dsl.send(weekday, :second)
        assertion.class.should      == Clockwork::Intersection
        assertion.attributes.should == [:wday, :wday_in_month]
        assertion.values.should     == [index, 2]
      end
    end
  end
  
  describe "month shortcuts (MONTHS)" do
    Clockwork::Dsl::MONTHS.each_with_index do |month, index|
      value = index + 1
      
      it "should return a :month Assertion with value #{value} when Dsl.#{month} is called" do
        assertion = Clockwork::Dsl.send(month)
        assertion.class.should     == Clockwork::Assertion
        assertion.attribute.should == :month
        assertion.value.should     == value
      end
    end
  end
end
