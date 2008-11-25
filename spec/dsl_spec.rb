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
  
  describe "#at" do
    it "should return an :hour Assertion if one element in array" do
      nine = Clockwork::Dsl.at([9])
      nine.class.should      == Clockwork::Assertion
      nine.attributes.should == [:hour]
      nine.values.should     == [9]
    end
    
    it "should return an Intersection of :hour, :min Assertions with two elements" do
      nine_15 = Clockwork::Dsl.at([9,15])
      nine_15.class.should      == Clockwork::Intersection
      nine_15.attributes.should == [:hour, :min]
      nine_15.values.should     == [9, 15]
    end
    
    it "should return an Intersection of :hour, :min, :sec Assertions with three elements" do
      nine_15_30 = Clockwork::Dsl.at([9,15, 30])
      nine_15_30.class.should      == Clockwork::Intersection
      nine_15_30.attributes.should == [:hour, :min, :sec]
      nine_15_30.values.should     == [9, 15, 30]
    end
  end
  
  describe "#from" do
    context "both endpoints have one element" do
      it "should return a Union of :hour Assertions if one element in array" do
        nine_to_12 = Clockwork::Dsl.from([9]..[12])
        nine.class.should      == Clockwork::Assertion
        nine.attributes.should == [:hour]
        nine.values.should     == [9..12]
      end
    end
    
    context "both endpoints have two elements" do
      it "should return a Union of :hour Assertions if one element in array" do
        nine_30_to_12_15 = Clockwork::Dsl.from([9,30]..[12,15])
        nine_30_to_12_15.should_be kind_of(Clockwork::Expression)
        nine_30_to_12_15.attributes.should == [:hour,   :min,  :hour, :hour,  :min]
        nine_30_to_12_15.values.should     == [    9, 30..59, 10..11,    12, 0..15]
      end
    end
    
    context "both endpoints have three elements" do
      it "should return an Intersection of :hour, :min, :sec Assertions with three elements" do
        nine_15_30_to_14_45_5 = Clockwork::Dsl.from([9,15,30]..[14,45,5])
        nine_15_30_to_14_45_5.should_be kind_of(Clockwork::Expression)
        # nine_15_30.attributes.should == [:hour, :min, :sec]
        # nine_15_30.values.should     == [9, 15, 30]
      end
    end
  end
end
