require File.dirname(__FILE__) + "/spec_helper"

describe Clockwork::Dsl do
  describe "arity one attribute assertions (ASSERTABLE_ATTRIBUTES)" do
    VALUES.each do |attribute, value|
      it "should return a[n] :#{attribute} Assertion when Dsl.#{attribute} is called" do
        expression = Clockwork::Dsl.send(attribute, value)
        expression.should be_kind_of(Clockwork::Assertion)
        expression.attribute.should == attribute
        expression.value.should     == value
        expression.to_sexp.should   == [:===, attribute, value]
      end
    end
  end
  
  describe "weekdays shortcuts (WEEKDAYS)" do
    Clockwork::Dsl::WEEKDAYS.each_with_index do |weekday, index|
      value = index
      
      it "should return a :wday Assertion with value #{value} when Dsl.#{weekday} is called" do
        expression = Clockwork::Dsl.send(weekday)
        expression.should be_kind_of(Clockwork::Assertion)
        expression.attribute.should == :wday
        expression.value.should     == value
        expression.to_sexp.should   == [:===, :wday, value]
      end
      
      it "should return a :wday Assertion with value #{value} when Dsl.#{weekday}s is called" do
        expression = Clockwork::Dsl.send("#{weekday}s")
        expression.should be_kind_of(Clockwork::Assertion)
        expression.attribute.should == :wday
        expression.value.should     == value
        expression.to_sexp.should   == [:===, :wday, value]
      end
      
      it "should accept an Integer argument which defines an intersecting :wday_in_month Assertion" do
        expression = Clockwork::Dsl.send(weekday, 1)
        expression.should be_kind_of(Clockwork::Intersection)
        expression.attributes.should == [:wday, :wday_in_month]
        expression.values.should     == [index, 1]
        expression.to_sexp.should    == [:&, [:===, :wday, index], [:===, :wday_in_month, 1]]
      end
      
      it "should accept a Symbol argument which defines an intersecting :wday_in_month Assertion" do
        expression = Clockwork::Dsl.send(weekday, :second)
        expression.should be_kind_of(Clockwork::Intersection)
        expression.attributes.should == [:wday, :wday_in_month]
        expression.values.should     == [index, 2]
        expression.to_sexp.should    == [:&, [:===, :wday, index], [:===, :wday_in_month, 2]]
      end
    end
  end
  
  describe "month shortcuts (MONTHS)" do
    Clockwork::Dsl::MONTHS.each_with_index do |month, index|
      value = index + 1
      
      it "should return a :month Assertion with value #{value} when Dsl.#{month} is called" do
        expression = Clockwork::Dsl.send(month)
        expression.should be_kind_of(Clockwork::Assertion)
        expression.attribute.should == :month
        expression.value.should     == value
        expression.to_sexp.should   == [:===, :month, value]
      end
    end
  end
  
  describe "#at" do
    it "should return an :hour Assertion if one element in array" do
      expression = Clockwork::Dsl.at([9])
      expression.should be_kind_of(Clockwork::Assertion)
      expression.to_sexp.should == [:===, :hour, 9]
    end
    
    it "should return an Intersection of :hour, :min Assertions with two elements" do
      expression = Clockwork::Dsl.at([9,15])
      expression.should be_kind_of(Clockwork::Intersection)
      expression.to_sexp.should == [:&, [:===, :hour, 9], [:===, :min, 15]]
    end
    
    it "should return an Intersection of :hour, :min, :sec Assertions with three elements" do
      expression = Clockwork::Dsl.at([9,15, 30])
      expression.should be_kind_of(Clockwork::Intersection)
      expression.to_sexp.should == [:&, [:===, :hour, 9], [:===, :min, 15], [:===, :sec, 30]]
    end
  end
  
  describe "#from" do
    describe "when both endpoints do not have the same number of elements" do
      it "should return a Union of :hour Assertions if one element in array" do
        expression = Clockwork::Dsl.from([9]..[12,30])
        expression.should be_kind_of(Clockwork::Expression)
        expression.to_sexp.should == [:|, [:===, :hour, 9..11], [:&, [:===, :hour, 12], [:===, :min, 0..30]]]
      end

      it "should return a Union of :hour Assertions if two elements in array" do
        expression = Clockwork::Dsl.from([9,30]..[12])
        expression.should be_kind_of(Clockwork::Expression)
        expression.to_sexp.should == [:|, [:&, [:===, :hour, 9], [:===, :min, 30..59]], [:===, :hour, 10..12]]
      end
    end

    describe "when both endpoints have the same number of elements" do
      it "should return a Union of :hour Assertions if one element in array" do
        expression = Clockwork::Dsl.from([9]..[12])
        expression.should be_kind_of(Clockwork::Expression)
        expression.to_sexp.should == [:===, :hour, 9..12]
      end

      it "should return a Union of :hour Assertions if one element in array" do
        expression = Clockwork::Dsl.from([9,30]..[12,15])
        expression.should be_kind_of(Clockwork::Expression)
        expression.to_sexp.should == [:|, [:&, [:===, :hour, 9], [:===, :min, 30..59]], [:===, :hour, 10..11], [:&, [:===, :hour, 12], [:===, :min, 0..15]]]
      end

      it "should return an Intersection of :hour, :min, :sec Assertions with three elements" do
        expression = Clockwork::Dsl.from([9,15,30]..[14,45,5])
        expression.should be_kind_of(Clockwork::Expression)
        expression.to_sexp.should == [:|, [:&, [:===, :hour, 9], [:|, [:===, :min, 16..59], [:&, [:===, :min, 15], [:===, :sec, 30..60]]]], [:===, :hour, 10..13], [:&, [:===, :hour, 14], [:|, [:===, :min, 0..44], [:&, [:===, :min, 45], [:===, :sec, 0..5]]]]]
      end
    end
    
    describe "both endpoints have three elements" do
    end
  end
end
