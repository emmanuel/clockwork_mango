require "spec_helper"

module ClockworkMango
  describe Dsl do
    describe "arity one attribute assertions (COMPARABLE_ATTRIBUTES)" do
      VALUES.each do |attribute, value|
        it "should return a[n] :#{attribute} ComparisonPredicate when Dsl.#{attribute} is called" do
          predicate = Dsl.send(attribute, value)
          predicate.should be_kind_of(ComparisonPredicate)
          predicate.attribute.should == attribute
          predicate.value.should     == value
          predicate.to_sexp.should   == [:==, attribute, value]
        end
      end
    end

    describe "weekdays shortcuts (WEEKDAYS)" do
      Dsl::WEEKDAYS.each_with_index do |weekday, index|
        value = index

        describe "Dsl.#{weekday}[s]" do
          it "should return the expected EqualityPredicate" do
            predicate = Dsl.send(weekday)
            predicate.should be_kind_of(EqualityPredicate)
            predicate.to_sexp.should == [:==, :wday, value]
          end

          it "should be generated with plural :#{weekday}s" do
            Dsl.send("#{weekday}s").to_sexp.should == [:==, :wday, value]
          end

          it "should accept an Integer argument which defines an intersecting :wday_in_month EqualityPredicate" do
            predicate = Dsl.send(weekday, 1)
            predicate.should be_kind_of(IntersectionPredicate)
            predicate.attributes.should == [:wday, :wday_in_month]
            predicate.values.should     == [index, 1]
            predicate.to_sexp.should    == [:&, [:==, :wday, index], [:==, :wday_in_month, 1]]
          end

          it "should accept a Symbol argument which defines an intersecting :wday_in_month EqualityPredicate" do
            predicate = Dsl.send(weekday, :second)
            predicate.should be_kind_of(IntersectionPredicate)
            predicate.attributes.should == [:wday, :wday_in_month]
            predicate.values.should     == [index, 2]
            predicate.to_sexp.should    == [:&, [:==, :wday, index], [:==, :wday_in_month, 2]]
          end
        end # describe Dsl.#{weekday}s
      end

    end

    describe "month shortcuts (MONTHS)" do
      Dsl::MONTHS.each_with_index do |month, index|
        value = index + 1

        it "should return a :month EqualityPredicate with value #{value} when Dsl.#{month} is called" do
          predicate = Dsl.send(month)
          predicate.should be_kind_of(EqualityPredicate)
          predicate.attribute.should == :month
          predicate.value.should     == value
          predicate.to_sexp.should   == [:==, :month, value]
        end
      end
    end

    describe "#at" do
      it "should return an :hour EqualityPredicate if one element in array" do
        predicate = Dsl.at(9)
        predicate.should be_kind_of(EqualityPredicate)
        predicate.to_sexp.should == [:==, :hour, 9]
      end

      it "should return an IntersectionPredicate of :hour, :min EqualityPredicates with two elements" do
        predicate = Dsl.at(9,15)
        predicate.should be_kind_of(IntersectionPredicate)
        predicate.to_sexp.should == [:&, [:==, :hour, 9], [:==, :min, 15]]
      end

      it "should return an IntersectionPredicate of :hour, :min, :sec EqualityPredicates with three elements" do
        predicate = Dsl.at(9,15,30)
        predicate.should be_kind_of(IntersectionPredicate)
        predicate.to_sexp.should == [:&, [:==, :hour, 9], [:==, :min, 15], [:==, :sec, 30]]
      end
    end

    describe "#from" do
      describe "when both endpoints do not have the same number of elements" do
        it "should return a UnionPredicate of :hour EqualityPredicates if one element in array" do
          predicate = Dsl.from([9]..[12,30])
          predicate.should be_kind_of(UnionPredicate)
          predicate.to_sexp.should == [:|, [:==, :hour, 9..11], [:&, [:==, :hour, 12], [:==, :min, 0..30]]]
        end

        it "should return a UnionPredicate of :hour EqualityPredicates if two elements in array" do
          predicate = Dsl.from([9,30]..[12])
          predicate.should be_kind_of(UnionPredicate)
          predicate.to_sexp.should == [:|, [:&, [:==, :hour, 9], [:==, :min, 30..59]], [:==, :hour, 10..12]]
        end
      end

      describe "when both endpoints have the same number of elements" do
        it "should return a EqualityPredicate on :hour if one element in array" do
          predicate = Dsl.from([9]..[12])
          predicate.should be_kind_of(EqualityPredicate)
          predicate.to_sexp.should == [:==, :hour, 9..12]
        end

        it "should return a UnionPredicate of :hour EqualityPredicates with two elements in array" do
          predicate = Dsl.from([9,30]..[12,15])
          predicate.should be_kind_of(UnionPredicate)
          predicate.to_sexp.should == [:|, [:&, [:==, :hour, 9], [:==, :min, 30..59]], [:==, :hour, 10..11], [:&, [:==, :hour, 12], [:==, :min, 0..15]]]
        end

        it "should return an IntersectionPredicate of :hour, :min, :sec EqualityPredicates with three elements" do
          predicate = Dsl.from([9,15,30]..[14,45,5])
          predicate.should be_kind_of(UnionPredicate)
          predicate.to_sexp.should == [:|, [:&, [:==, :hour, 9], [:|, [:==, :min, 16..59], [:&, [:==, :min, 15], [:==, :sec, 30..60]]]], [:==, :hour, 10..13], [:&, [:==, :hour, 14], [:|, [:==, :min, 0..44], [:&, [:==, :min, 45], [:==, :sec, 0..5]]]]]
        end
      end

      describe "both endpoints have three elements" do
      end

    end # describe "#from"
  end # describe Dsl
end # module ClockworkMango
