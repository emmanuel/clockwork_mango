require "spec_helper"

describe ClockworkMango::Dsl do
  describe "arity one attribute assertions (ASSERTABLE_ATTRIBUTES)" do
    VALUES.each do |attribute, value|
      it "should return a[n] :#{attribute} ComparisonPredicate when Dsl.#{attribute} is called" do
        predicate = ClockworkMango::Dsl.send(attribute, value)
        predicate.should be_kind_of(ClockworkMango::ComparisonPredicate)
        predicate.attribute.should == attribute
        predicate.value.should     == value
        predicate.to_sexp.should   == [:===, attribute, value]
      end
    end
  end

  describe "weekdays shortcuts (WEEKDAYS)" do
    ClockworkMango::Dsl::WEEKDAYS.each_with_index do |weekday, index|
      value = index

      it "should return a :wday ComparisonPredicate with value #{value} when Dsl.#{weekday} is called" do
        predicate = ClockworkMango::Dsl.send(weekday)
        predicate .should be_kind_of(ClockworkMango::ComparisonPredicate)
        predicate.attribute.should == :wday
        predicate.value.should     == value
        predicate.to_sexp.should   == [:===, :wday, value]
      end

      it "should return a :wday ComparisonPredicate with value #{value} when Dsl.#{weekday}s is called" do
        predicate = ClockworkMango::Dsl.send("#{weekday}s")
        predicate.should be_kind_of(ClockworkMango::ComparisonPredicate)
        predicate.attribute.should == :wday
        predicate.value.should     == value
        predicate.to_sexp.should   == [:===, :wday, value]
      end

      it "should accept an Integer argument which defines an intersecting :wday_in_month ComparisonPredicate" do
        predicate = ClockworkMango::Dsl.send(weekday, 1)
        predicate.should be_kind_of(ClockworkMango::IntersectionPredicate)
        predicate.attributes.should == [:wday, :wday_in_month]
        predicate.values.should     == [index, 1]
        predicate.to_sexp.should    == [:&, [:===, :wday, index], [:===, :wday_in_month, 1]]
      end

      it "should accept a Symbol argument which defines an intersecting :wday_in_month ComparisonPredicate" do
        predicate = ClockworkMango::Dsl.send(weekday, :second)
        predicate.should be_kind_of(ClockworkMango::IntersectionPredicate)
        predicate.attributes.should == [:wday, :wday_in_month]
        predicate.values.should     == [index, 2]
        predicate.to_sexp.should    == [:&, [:===, :wday, index], [:===, :wday_in_month, 2]]
      end
    end

  end

  describe "month shortcuts (MONTHS)" do
    ClockworkMango::Dsl::MONTHS.each_with_index do |month, index|
      value = index + 1

      it "should return a :month ComparisonPredicate with value #{value} when Dsl.#{month} is called" do
        predicate = ClockworkMango::Dsl.send(month)
        predicate.should be_kind_of(ClockworkMango::ComparisonPredicate)
        predicate.attribute.should == :month
        predicate.value.should     == value
        predicate.to_sexp.should   == [:===, :month, value]
      end
    end
  end

  describe "#at" do
    it "should return an :hour ComparisonPredicate if one element in array" do
      predicate = ClockworkMango::Dsl.at([9])
      predicate.should be_kind_of(ClockworkMango::ComparisonPredicate)
      predicate.to_sexp.should == [:===, :hour, 9]
    end

    it "should return an IntersectionPredicate of :hour, :min ComparisonPredicates with two elements" do
      predicate = ClockworkMango::Dsl.at([9,15])
      predicate.should be_kind_of(ClockworkMango::IntersectionPredicate)
      predicate.to_sexp.should == [:&, [:===, :hour, 9], [:===, :min, 15]]
    end

    it "should return an IntersectionPredicate of :hour, :min, :sec ComparisonPredicates with three elements" do
      predicate = ClockworkMango::Dsl.at([9,15, 30])
      predicate.should be_kind_of(ClockworkMango::IntersectionPredicate)
      predicate.to_sexp.should == [:&, [:===, :hour, 9], [:===, :min, 15], [:===, :sec, 30]]
    end
  end

  describe "#from" do
    describe "when both endpoints do not have the same number of elements" do
      it "should return a UnionPredicate of :hour ComparisonPredicates if one element in array" do
        predicate = ClockworkMango::Dsl.from([9]..[12,30])
        predicate.should be_kind_of(ClockworkMango::UnionPredicate)
        predicate.to_sexp.should == [:|, [:===, :hour, 9..11], [:&, [:===, :hour, 12], [:===, :min, 0..30]]]
      end

      it "should return a UnionPredicate of :hour ComparisonPredicates if two elements in array" do
        predicate = ClockworkMango::Dsl.from([9,30]..[12])
        predicate.should be_kind_of(ClockworkMango::UnionPredicate)
        predicate.to_sexp.should == [:|, [:&, [:===, :hour, 9], [:===, :min, 30..59]], [:===, :hour, 10..12]]
      end
    end

    describe "when both endpoints have the same number of elements" do
      it "should return a ComparisonPredicate on :hour if one element in array" do
        predicate = ClockworkMango::Dsl.from([9]..[12])
        predicate.should be_kind_of(ClockworkMango::ComparisonPredicate)
        predicate.to_sexp.should == [:===, :hour, 9..12]
      end

      it "should return a UnionPredicate of :hour ComparisonPredicates with two elements in array" do
        predicate = ClockworkMango::Dsl.from([9,30]..[12,15])
        predicate.should be_kind_of(ClockworkMango::UnionPredicate)
        predicate.to_sexp.should == [:|, [:&, [:===, :hour, 9], [:===, :min, 30..59]], [:===, :hour, 10..11], [:&, [:===, :hour, 12], [:===, :min, 0..15]]]
      end

      it "should return an IntersectionPredicate of :hour, :min, :sec ComparisonPredicates with three elements" do
        predicate = ClockworkMango::Dsl.from([9,15,30]..[14,45,5])
        predicate.should be_kind_of(ClockworkMango::UnionPredicate)
        predicate.to_sexp.should == [:|, [:&, [:===, :hour, 9], [:|, [:===, :min, 16..59], [:&, [:===, :min, 15], [:===, :sec, 30..60]]]], [:===, :hour, 10..13], [:&, [:===, :hour, 14], [:|, [:===, :min, 0..44], [:&, [:===, :min, 45], [:===, :sec, 0..5]]]]]
      end
    end

    describe "both endpoints have three elements" do
    end

  end
end
