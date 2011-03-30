require "spec_helper"
require "clockwork_mango/dsl"

module ClockworkMango
  describe Dsl do
    describe "arity one attribute assertions (COMPARABLE_ATTRIBUTES)" do
      VALUES.each do |attribute, value|
        it "should return a[n] :#{attribute} ComparisonPredicate when Dsl.#{attribute} is called" do
          subject = Dsl.send(attribute, value)
          subject.should be_kind_of(ComparisonPredicate)
          subject.attribute.should == attribute
          subject.value.should     == value
          subject.should express([:==, attribute, value])
        end
      end
    end

    describe "weekdays shortcuts (WEEKDAYS)" do
      Dsl::WEEKDAYS.each_with_index do |weekday, index|
        value = index

        describe "Dsl.#{weekday}[s]" do
          it "should return the expected EqualityPredicate" do
            subject = Dsl.send(weekday)
            subject.should be_kind_of(EqualityPredicate)
            subject.should express([:==, :wday, value])
          end

          it "should be generated with plural :#{weekday}s" do
            Dsl.send("#{weekday}s").should express([:==, :wday, value])
          end

          it "should accept an Integer argument which defines an intersecting :wday_in_month EqualityPredicate" do
            subject = Dsl.send(weekday, 1)
            subject.should be_kind_of(IntersectionPredicate)
            subject.attributes.should == [:wday, :wday_in_month]
            subject.values.should     == [index, 1]
            subject.should express([:&, [:==, :wday, index], [:==, :wday_in_month, 1]])
          end

          it "should accept a Symbol argument which defines an intersecting :wday_in_month EqualityPredicate" do
            subject = Dsl.send(weekday, :second)
            subject.should be_kind_of(IntersectionPredicate)
            subject.attributes.should == [:wday, :wday_in_month]
            subject.values.should     == [index, 2]
            subject.should express([:&, [:==, :wday, index], [:==, :wday_in_month, 2]])
          end
        end # describe Dsl.#{weekday}s
      end

    end

    describe "month shortcuts (MONTHS)" do
      Dsl::MONTHS.each_with_index do |month, index|
        value = index + 1

        it "should return a :month EqualityPredicate with value #{value} when Dsl.#{month} is called" do
          subject = Dsl.send(month)
          subject.should be_kind_of(EqualityPredicate)
          subject.attribute.should == :month
          subject.value.should     == value
          subject.should express([:==, :month, value])
        end
      end
    end

    describe "#at" do
      it "should return an :hour EqualityPredicate if one element in array" do
        subject = Dsl.at(9)
        subject.should be_kind_of(EqualityPredicate)
        subject.should express([:==, :hour, 9])
      end

      it "should return an IntersectionPredicate of :hour, :min EqualityPredicates with two elements" do
        subject = Dsl.at(9,15)
        subject.should be_kind_of(IntersectionPredicate)
        subject.should express([:&, [:==, :hour, 9], [:==, :min, 15]])
      end

      it "should return an IntersectionPredicate of :hour, :min, :sec EqualityPredicates with three elements" do
        subject = Dsl.at(9,15,30)
        subject.should be_kind_of(IntersectionPredicate)
        subject.should express([:&, [:==, :hour, 9], [:==, :min, 15], [:==, :sec, 30]])
      end
    end

    describe "#from" do
      context "with one arg (hh)" do
        it "should return a GreaterThanOrEqualPredicate" do
          subject = Dsl.from(9)
          subject.should be_kind_of(GreaterThanOrEqualPredicate)
          subject.should express([:>=, :hour, 9])
        end
      end

      context "with two args (hh,mm)" do
        it "should return a UnionPredicate of EqualityPredicate and GreaterThanPredicate" do
          subject = Dsl.from(9,15)
          subject.should be_kind_of(UnionPredicate)
          subject.should express([:|, [:>, :hour, 9], [:&, [:==, :hour, 9], [:>=, :min, 15]]])
        end
      end

      context "with three arg (hh,mm,ss)" do
        it "should return a UnionPredicate of EqualityPredicate and GreaterThanPredicate" do
          subject = Dsl.from(9,15,30)
          subject.should be_kind_of(UnionPredicate)
          subject.should express([:|, [:>, :hour, 9], [:&, [:==, :hour, 9], [:|, [:>, :min, 15], [:&, [:==, :min, 15], [:>=, :sec, 30]]]]])
        end
      end

      context "with a Range argument" do
        context "when range.begin is before range.end" do
          context "and both endpoints do not have the same number of elements" do
            it "should return a UnionPredicate of :hour EqualityPredicates if one element in array" do
              subject = Dsl.from([9]..[12,30])
              subject.should be_kind_of(UnionPredicate)
              subject.should express([:|, [:include?, :hour, 9..11], [:&, [:==, :hour, 12], [:include?, :min, 0..30]]])
            end

            it "should return a UnionPredicate of :hour EqualityPredicates if two elements in array" do
              subject = Dsl.from([9,30]..[12])
              subject.should be_kind_of(UnionPredicate)
              subject.should express([:|, [:&, [:==, :hour, 9], [:include?, :min, 30..59]], [:include?, :hour, 10..12]])
            end
          end

          context "and both endpoints have the same number of elements" do
            it "should return an EqualityPredicate on :hour if one element in array" do
              subject = Dsl.from([9]..[12])
              subject.should be_kind_of(InclusionPredicate)
              subject.should express([:include?, :hour, 9..12])
            end

            it "should return a UnionPredicate of :hour EqualityPredicates with two elements in array" do
              subject = Dsl.from([9,30]..[12,15])
              subject.should be_kind_of(UnionPredicate)
              subject.should express([:|, [:&, [:==, :hour, 9], [:include?, :min, 30..59]], [:include?, :hour, 10..11], [:&, [:==, :hour, 12], [:include?, :min, 0..15]]])
            end

            it "should return an IntersectionPredicate of :hour, :min, :sec EqualityPredicates with three elements" do
              subject = Dsl.from([9,15,30]..[14,45,5])
              subject.should be_kind_of(UnionPredicate)
              subject.should express([:|, [:&, [:==, :hour, 9], [:|, [:include?, :min, 16..59], [:&, [:==, :min, 15], [:include?, :sec, 30..60]]]], [:include?, :hour, 10..13], [:&, [:==, :hour, 14], [:|, [:include?, :min, 0..44], [:&, [:==, :min, 45], [:include?, :sec, 0..5]]]]])
            end
          end
        end

        context "when begin is after end (ie., it defines a wrap-around)" do
          context "and both endpoints do not have the same number of elements" do
            it "should return a UnionPredicate of :hour EqualityPredicates if one element in array" do
              subject = Dsl.from([19]..[6,30])
              subject.should be_kind_of(UnionPredicate)
              subject.should express([:|, [:include?, :hour, 19..23], [:include?, :hour, 0..5], [:&, [:==, :hour, 6], [:include?, :min, 0..30]]])
            end

            it "should return a UnionPredicate of :hour EqualityPredicates if two elements in array" do
              subject = Dsl.from([19,30]..[6])
              subject.should be_kind_of(UnionPredicate)
              subject.should express([:|, [:include?, :hour, 20..23], [:include?, :hour, 0..6], [:&, [:==, :hour, 19], [:include?, :min, 30..59]]])
            end
          end

          context "and both endpoints have the same number of elements" do
            it "should return a UnionPredicate of :hour, :min, :sec EqualityPredicates with three elements" do
              subject = Dsl.from([21]..[4])
              subject.should be_kind_of(UnionPredicate)
              subject.should express([:|, [:include?, :hour, 21..23], [:include?, :hour, 0..4]])
            end

            it "should return a UnionPredicate of :hour, :min, :sec EqualityPredicates with three elements" do
              subject = Dsl.from([21,15]..[4,45])
              subject.should be_kind_of(UnionPredicate)
              subject.should express([:|, [:&, [:==, :hour, 21], [:include?, :min, 15..59]], [:|, [:include?, :hour, 0..3], [:include?, :hour, 22..23]], [:&, [:==, :hour, 4], [:include?, :min, 0..45]]])
            end

            it "should return a UnionPredicate of :hour, :min, :sec EqualityPredicates with three elements" do
              subject = Dsl.from([21,15,30]..[4,45,25])
              subject.should be_kind_of(UnionPredicate)
              subject.should express([:|, [:&, [:==, :hour, 21], [:|, [:include?, :min, 16..59], [:&, [:==, :min, 15], [:include?, :sec, 30..60]]]], [:|, [:include?, :hour, 0..3], [:include?, :hour, 22..23]], [:&, [:==, :hour, 4], [:|, [:include?, :min, 0..44], [:&, [:==, :min, 45], [:include?, :sec, 0..25]]]]])
            end
          end
        end
      end # context "with a Range argument"
    end # describe "#from"

    describe "#until" do
      context "when given a single arg" do
        it "should return a LessThanOrEqualPredicate" do
          subject = Dsl.until(9)
          subject.should be_kind_of(LessThanOrEqualPredicate)
          subject.should express([:<=, :hour, 9])
        end
      end

      context "when given two args" do
        it "should return a UnionPredicate of EqualityPredicate and LessThanPredicate" do
          subject = Dsl.until(9,30)
          subject.should be_kind_of(UnionPredicate)
          subject.should express([:|, [:<, :hour, 9], [:&, [:==, :hour, 9], [:<=, :min, 30]]])
        end
      end

      context "when given three args" do
        it "should return a UnionPredicate of EqualityPredicate and LessThanPredicate" do
          subject = Dsl.until(9,30,15)
          subject.should be_kind_of(UnionPredicate)
          subject.should express([:|, [:<, :hour, 9], [:&, [:==, :hour, 9], [:|, [:<, :min, 30], [:&, [:==, :min, 30], [:<=, :sec, 15]]]]])
        end
      end
    end # describe "#until"

    describe "Predicate#from" do
      let(:predicate) { Dsl.mondays }

      it "should return IntersectionPredicate" do
        subject = predicate.from([19,00]..[21,30])
        subject.should be_kind_of(IntersectionPredicate)
        subject.should express([:&, [:==, :wday, 1], [:|, [:&, [:==, :hour, 19], [:include?, :min, 00..59]], [:==, :hour, 20], [:&, [:==, :hour, 21], [:include?, :min, 0..30]]]])
      end
    end

    describe "Predicate#at" do
      let(:predicate) { Dsl.mondays }

      it "should return IntersectionPredicate" do
        subject = predicate.at(19,00)
        subject.should be_kind_of(IntersectionPredicate)
        subject.should express([:&, [:==, :wday, 1], [:&, [:==, :hour, 19], [:==, :min, 0]]])
      end
    end

  end # describe Dsl
end # module ClockworkMango
