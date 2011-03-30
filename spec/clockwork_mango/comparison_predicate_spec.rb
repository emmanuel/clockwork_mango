require "spec_helper"
require "clockwork_mango/comparison_predicate"

module ClockworkMango
  describe ComparisonPredicate do
    let(:date)      { Date.new(*DATE_ATTRIBUTES.map { |a| VALUES[a] }) }
    let(:datetime)  { DateTime.new(*DATETIME_ATTRS.map { |a| VALUES[a] }) }
    let(:time)      { Time.local(*TIME_ATTRIBUTES.map { |a| VALUES[a] }) }

    before :all do
      @values = { Date => date, DateTime => datetime, Time => time }
    end

    describe "DAY_PRECISION_UNITS" do
      DAY_PRECISION_UNITS.each do |attr|
        value = VALUES[attr]
        random = rand(99)

        [::Time, ::DateTime, ::Date].each do |klass|
          it "should match #{klass}s on asserted #{attr} integer value" do
            EqualityPredicate.new(attr, value).should === @values[klass]
          end

          it "should match #{klass}s on asserted #{attr} range value" do
            InclusionPredicate.new(attr, (value - 1)..(value + 1)).should === @values[klass]
          end

          it "should not match #{klass}s on any other #{attr} value" do
            EqualityPredicate.new(attr, value - 1).should_not === @values[klass]
            EqualityPredicate.new(attr, value + 1).should_not === @values[klass]
            EqualityPredicate.new(attr, value + random).should_not === @values[klass]
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
            EqualityPredicate.new(attr, value).should === @values[klass]
          end

          it "should match #{klass} objects on asserted #{attr} range value" do
            InclusionPredicate.new(attr, (value - 1)..(value + 1)).should === @values[klass]
          end

          if specific
            it "should not match #{klass} objects on any other #{attr} value" do
              EqualityPredicate.new(attr, value - 1).should_not === @values[klass]
              EqualityPredicate.new(attr, value + 1).should_not === @values[klass]
              EqualityPredicate.new(attr, value + random).should_not === @values[klass]
            end
          else
            it "should match #{klass} objects on any other #{attr} value" do
              EqualityPredicate.new(attr, value - 1).should === @values[klass]
              EqualityPredicate.new(attr, value + 1).should === @values[klass]
              EqualityPredicate.new(attr, value + random).should === @values[klass]
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
            EqualityPredicate.new(attr, value).should === @values[klass]
          end

          it "should match #{klass} objects on asserted #{attr} range value" do
            InclusionPredicate.new(attr, (value - 1)..(value + 1)).should === @values[klass]
          end

          if specific
            it "should not match #{klass} objects on any other #{attr} value" do
              EqualityPredicate.new(attr, value - 1).should_not === @values[klass]
              EqualityPredicate.new(attr, value + 1).should_not === @values[klass]
              EqualityPredicate.new(attr, value + random).should_not === @values[klass]
            end
          else
            it "should match #{klass} objects on any other #{attr} value" do
              EqualityPredicate.new(attr, value - 1).should === @values[klass]
              EqualityPredicate.new(attr, value + 1).should === @values[klass]
              EqualityPredicate.new(attr, value + random).should === @values[klass]
            end
          end
        end
      end
    end # describe "USECOND_PRECISION_UNITS"

    describe "#to_temporal_sexp" do
      ClockworkMango::COMPARABLE_ATTRIBUTES.each do |attribute|
        context ":#{attribute} EqualityPredicates" do
          (0..4).each do |value|
            context "with value #{value}" do
              describe ComparisonPredicate do
                it "should return [:===, :#{attribute}, #{value}]" do
                  predicate = ComparisonPredicate.new(attribute, value)
                  predicate.to_temporal_sexp.should == [:===, attribute, value]
                end
              end

              describe EqualityPredicate do
                it "should return [:==, :#{attribute}, #{value}] with value #{value}" do
                  predicate = EqualityPredicate.new(attribute, value)
                  predicate.to_temporal_sexp.should == [:==, attribute, value]
                end
              end

              describe InclusionPredicate do
                it "should return [:include?, :#{attribute}, #{value}] with value #{value}" do
                  range = value..(value + 3)
                  predicate = InclusionPredicate.new(attribute, range)
                  predicate.to_temporal_sexp.should == [:include?, attribute, range]
                end
              end

              describe ExclusionPredicate do
                it "should return [:exclude?, :#{attribute}, #{value}] with value #{value}" do
                  range = value..(value + 3)
                  predicate = ExclusionPredicate.new(attribute, range)
                  predicate.to_temporal_sexp.should == [:exclude?, attribute, range]
                end
              end

              describe GreaterThanPredicate do
                it "should return [:>, :#{attribute}, #{value}] with value #{value}" do
                  predicate = GreaterThanPredicate.new(attribute, value)
                  predicate.to_temporal_sexp.should == [:>, attribute, value]
                end
              end

              describe LessThanPredicate do
                it "should return [:<, :#{attribute}, #{value}] with value #{value}" do
                  predicate = LessThanPredicate.new(attribute, value)
                  predicate.to_temporal_sexp.should == [:<, attribute, value]
                end
              end
            end
          end
        end
      end
    end # describe "#to_temporal_sexp"

    describe "#next_occurrence_after" do
      let(:start)     { Time.utc(2004, 2, 1, 12, 15, 12) }
      let(:next_29th) { Time.utc(2004, 2, 29) }
      let(:date)      { Date.new(2004, 2, 1) }
      let(:date_time) { DateTime.new(2004, 2, 1, 12, 15, 12) }
      let(:time)      { start }
      let(:day_1)    { EqualityPredicate.new(:day, 1) }
      let(:day_29)   { EqualityPredicate.new(:day, 29) }

      context "with no arguments" do
        it "should return a single Time object" do
          day_1.next_occurrence.should be_an_instance_of(Time)
        end

        it "should return a value that matches the receiver" do
          day_1.should === day_1.next_occurrence
        end
      end

      context "with a single Time argument" do
        let(:predicate)  { day_1 }
        subject { predicate.next_occurrence_after(@given_time) }

        context "with no argument" do
          subject { predicate.next_occurrence }

          it "returns a Time in UTC" do
            subject.should be_utc
          end

          it "returns an object that matches the receiver" do
            predicate.should === subject
          end
        end

        context "when given a Time" do
          context "regardless of zone" do
            before { @given_time = start }

            it "returns an object that matches the receiver" do
              predicate.should === subject
            end

            it "returns a Time object that occurs after its argument" do
              subject.should > start
            end
          end

          context "in UTC" do
            before { @given_time = Time.utc(2004, 2, 1) }

            it "checks argument" do
              @given_time.should be_utc
            end

            it "returns a Time in UTC" do
              subject.zone.should == @given_time.zone
            end
          end

          context "with zone" do
            before { @given_time = Time.local(2004, 2, 1) }

            it "checks argument" do
              @given_time.should_not be_utc
            end

            it "returns a Time in the original zone" do
              subject.zone.should == @given_time.zone
            end
          end
        end
      end

      it "should return a temporal object of the same class as its argument" do
        day_1.next_occurrence_after(date).should      be_instance_of(Date)
        day_1.next_occurrence_after(date_time).should be_instance_of(DateTime)
        day_1.next_occurrence_after(time).should      be_instance_of(Time)
      end

      it "should return a value that matches the receiver" do
        day_1.should === day_1.next_occurrence_after(start)
      end

      context "when @attribute is :sec" do
        it "should return a time within the current minute when value is greater than start.sec" do
          next_time = Time.utc(2004, 2, 1, 12, 15, 29)
          start.should < next_time
          start.sec.should < next_time.sec
          EqualityPredicate.new(:sec, 29).next_occurrence_after(start).should == next_time
        end

        it "should return a time within the next minute when value is less than start.sec" do
          next_time = Time.utc(2004, 2, 1, 12, 16, 02)
          start.should < next_time
          start.sec.should > next_time.sec
          EqualityPredicate.new(:sec, 2).next_occurrence_after(start).should == next_time
        end
      end

      context "when @attribute is :min" do
        it "should return a time within the current hour when value is greater than start.min" do
          next_time = Time.utc(2004, 2, 1, 12, 18)
          start.should < next_time
          start.min.should < next_time.min
          EqualityPredicate.new(:min, 18).next_occurrence_after(start).should == next_time
        end

        it "should return a time within the next hour when value is less than start.min" do
          next_time = Time.utc(2004, 2, 1, 13, 2)
          start.should < next_time
          start.min.should > next_time.min
          EqualityPredicate.new(:min, 2).next_occurrence_after(start).should == next_time
        end
      end

      context "when @attribute is :hour" do
        it "should return a time within the current day when value is greater than start.hour" do
          next_time = Time.utc(2004, 2, 1, 16)
          start.should < next_time
          start.hour.should < next_time.hour
          EqualityPredicate.new(:hour, 16).next_occurrence_after(start).should == next_time
        end

        it "should return a time within the next day when value is less than start.hour" do
          next_time = Time.utc(2004, 2, 2, 6)
          start.should < next_time
          start.hour.should > next_time.hour
          EqualityPredicate.new(:hour, 6).next_occurrence_after(start).should == next_time
        end
      end

      context "when @attribute is :day" do
        it "should return 'Sun Feb 29 00:00:00 UTC 2004' when asked for the next 29th day after 'Sun Feb 01 00:00:00 UTC 2004'" do
          day_29.next_occurrence_after(start).should == next_29th
        end

        it "should reset hours, minutes, and seconds when advancing day" do
          start = Time.utc(2004, 2, 1, 12, 15, 12)
          day_29.next_occurrence_after(start).should == next_29th
        end

        it "should return a time within the current month when value is greater than start.day" do
          next_time = Time.utc(2004, 2, 9)
          start.should < next_time
          start.day.should < next_time.day
          EqualityPredicate.new(:day, 9).next_occurrence_after(start).should == next_time
        end

        it "should return a time within the next month when value is less than start.day" do
          start = Time.utc(2004, 2, 15)
          next_time = Time.utc(2004, 3, 1)
          start.should < next_time
          start.day.should > next_time.day
          day_1.next_occurrence_after(start).should == next_time
        end
      end

      context "when @attribute is :month" do
        it "should return a time within the current year when value is greater than start.month" do
          next_time = Time.utc(2004, 3, 1)
          start.should < next_time
          start.month.should < next_time.month
          EqualityPredicate.new(:month, 3).next_occurrence_after(start).should == next_time
        end

        it "should return a time within the next year when value is less than start.month" do
          next_time = Time.utc(2005, 1, 1)
          start.should < next_time
          start.month.should > next_time.month
          EqualityPredicate.new(:month, 1).next_occurrence_after(start).should == next_time
        end
      end

      context "when @attribute is :year" do
        let(:next_time) { Time.utc(2006, 1, 1, 00, 00, 00) }

        it "should return nil when value is less than start.year" do
          EqualityPredicate.new(:year, 2003).next_occurrence_after(start).should == nil
        end

        it "should return the beginning of the asserted year when value is greater than start.year" do
          start.should < next_time
          start.year.should < next_time.year
          EqualityPredicate.new(:year, 2006).next_occurrence_after(start).should == next_time
        end
      end
    end
  end
end
