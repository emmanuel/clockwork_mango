require "spec_helper"

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

    describe "#to_sexp" do
      ClockworkMango::COMPARABLE_ATTRIBUTES.each do |attribute|
        context ":#{attribute} EqualityPredicates" do
          (0..4).each do |value|
            context "with value #{value}" do
              describe EqualityPredicate do
                it "should return [:===, :#{attribute}, #{value}]" do
                  ComparisonPredicate.new(attribute, value).to_sexp.should == [:===, attribute, value]
                end
              end

              describe EqualityPredicate do
                it "should return [:==, :#{attribute}, #{value}] with value #{value}" do
                  EqualityPredicate.new(attribute, value).to_sexp.should == [:==, attribute, value]
                end
              end

              describe InclusionPredicate do
                it "should return [:include?, :#{attribute}, #{value}] with value #{value}" do
                  range = value..(value + 3)
                  InclusionPredicate.new(attribute, range).to_sexp.should == [:include?, attribute, range]
                end
              end

              describe ExclusionPredicate do
                it "should return [:exclude?, :#{attribute}, #{value}] with value #{value}" do
                  range = value..(value + 3)
                  ExclusionPredicate.new(attribute, range).to_sexp.should == [:exclude?, attribute, range]
                end
              end

              describe GreaterThanPredicate do
                it "should return [:>, :#{attribute}, #{value}] with value #{value}" do
                  GreaterThanPredicate.new(attribute, value).to_sexp.should == [:>, attribute, value]
                end
              end

              describe LessThanPredicate do
                it "should return [:<, :#{attribute}, #{value}] with value #{value}" do
                  LessThanPredicate.new(attribute, value).to_sexp.should == [:<, attribute, value]
                end
              end
            end
          end
        end
      end
    end # describe "#to_sexp"

    describe "#next_occurrence" do
      let(:start)     { Time.parse("Sun Feb 01 00:00:00 UTC 2004") }
      let(:next_29th) { Time.parse("Sun Feb 29 00:00:00 UTC 2004") }
      let(:date)      { start.to_date }
      let(:date_time) { start.to_datetime }
      let(:time)      { start }
      let(:mday_1)    { EqualityPredicate.new(:day, 1) }
      let(:mday_29)   { EqualityPredicate.new(:day, 29) }

      context "with no arguments" do
        it "should return a single Time object" do
          mday_1.next_occurrence.should be_an_instance_of(Time)
        end

        it "should return a value that matches the receiver" do
          mday_1.should === mday_1.next_occurrence
        end
      end

      context "with a single Time argument" do
        it "should return an object representing the next occurrence of the receiver" do
          next_occurrence = Time.utc(start.year, start.month + 1, 1)
          mday_1.next_occurrence_after(start).should == next_occurrence
        end

        it "should return a Time object that occurs after its argument" do
          mday_1.next_occurrence_after(start).should > start
        end

        it "should return a Time object in the UTC zone with no argument" do
          mday_1.next_occurrence.zone.should == "UTC"
        end

        it "should return a Time object with the same zone as its argument" do
          time_in_utc = Time.parse("Sun Feb 01 00:00:00 UTC 2004")
          mday_1.next_occurrence_after(time_in_utc).zone.should == time_in_utc.zone
          local = Time.parse("Sun Feb 01 00:00:00 -0800 2004")
          mday_1.next_occurrence_after(local).zone.should == local.zone
        end
      end

      it "should return a temporal object of the same class as its argument" do
        mday_1.next_occurrence_after(date).should      be_instance_of(Date)
        mday_1.next_occurrence_after(date_time).should be_instance_of(DateTime)
        mday_1.next_occurrence_after(time).should      be_instance_of(Time)
      end

      it "should return a value that matches the receiver" do
        mday_1.should === mday_1.next_occurrence_after(start)
      end

      context "when @attribute is :sec" do
        it "should return a time within the current minute when value is greater than start.sec" do
          start = Time.parse("Sun Feb 01 12:15:12 UTC 2004")
          next_time = Time.parse("Sun Feb 01 12:15:29 UTC 2004")
          start.should < next_time
          start.sec.should < next_time.sec
          EqualityPredicate.new(:sec, 29).next_occurrence_after(start).should == next_time
        end

        it "should return a time within the next minute when value is less than start.sec" do
          start = Time.parse("Sun Feb 01 12:15:12 UTC 2004")
          next_time = Time.parse("Sun Feb 01 12:16:02 UTC 2004")
          start.should < next_time
          start.sec.should > next_time.sec
          EqualityPredicate.new(:sec, 2).next_occurrence_after(start).should == next_time
        end
      end

      context "when @attribute is :min" do
        it "should return a time within the current hour when value is greater than start.min" do
          start = Time.parse("Sun Feb 01 12:15:12 UTC 2004")
          next_time = Time.parse("Sun Feb 01 12:18:00 UTC 2004")
          start.should < next_time
          start.min.should < next_time.min
          EqualityPredicate.new(:min, 18).next_occurrence_after(start).should == next_time
        end

        it "should return a time within the next hour when value is less than start.min" do
          start = Time.parse("Sun Feb 01 12:15:12 UTC 2004")
          next_time = Time.parse("Sun Feb 01 13:02:00 UTC 2004")
          start.should < next_time
          start.min.should > next_time.min
          EqualityPredicate.new(:min, 2).next_occurrence_after(start).should == next_time
        end
      end

      context "when @attribute is :hour" do
        it "should return a time within the current day when value is greater than start.hour" do
          start = Time.parse("Sun Feb 01 12:15:12 UTC 2004")
          next_time = Time.parse("Sun Feb 01 16:00:00 UTC 2004")
          start.should < next_time
          start.hour.should < next_time.hour
          EqualityPredicate.new(:hour, 16).next_occurrence_after(start).should == next_time
        end

        it "should return a time within the next day when value is less than start.hour" do
          start = Time.parse("Sun Feb 01 12:15:12 UTC 2004")
          next_time = Time.parse("Mon Feb 02 06:00:00 UTC 2004")
          start.should < next_time
          start.hour.should > next_time.hour
          EqualityPredicate.new(:hour, 6).next_occurrence_after(start).should == next_time
        end
      end

      context "when @attribute is :day (or :mday)" do
        it "should return 'Sun Feb 29 00:00:00 UTC 2004' when asked for the next 29th day after 'Sun Feb 01 00:00:00 UTC 2004'" do
          mday_29.next_occurrence_after(start).should == next_29th
        end

        it "should reset hours, minutes, and seconds when advancing day" do
          start = Time.parse("Sun Feb 01 12:15:12 UTC 2004")
          mday_29.next_occurrence_after(start).should == next_29th
        end

        it "should return a time within the current month when value is greater than start.day" do
          start = Time.parse("Sun Feb 01 12:15:12 UTC 2004")
          next_time = Time.parse("Mon Feb 09 00:00:00 UTC 2004")
          start.should < next_time
          start.day.should < next_time.day
          EqualityPredicate.new(:day, 9).next_occurrence_after(start).should == next_time
        end

        it "should return a time within the next month when value is less than start.day" do
          start = Time.parse("Mon Feb 02 12:15:12 UTC 2004")
          next_time = Time.parse("Mon Mar 01 00:00:00 UTC 2004")
          start.should < next_time
          start.mday.should > next_time.day
          mday_1.next_occurrence_after(start).should == next_time
        end
      end

      context "when @attribute is :month" do
        it "should return a time within the current year when value is greater than start.month" do
          start = Time.parse("Sun Feb 01 12:15:12 UTC 2004")
          next_time = Time.parse("Mon Mar 01 00:00:00 UTC 2004")
          start.should < next_time
          start.month.should < next_time.month
          EqualityPredicate.new(:month, 3).next_occurrence_after(start).should == next_time
        end

        it "should return a time within the next year when value is less than start.month" do
          start = Time.parse("Mon Feb 02 12:15:12 UTC 2004")
          next_time = Time.parse("Sat Jan 01 00:00:00 UTC 2005")
          start.should < next_time
          start.month.should > next_time.month
          EqualityPredicate.new(:month, 1).next_occurrence_after(start).should == next_time
        end
      end

      context "when @attribute is :year" do
        it "should return nil when value is less than start.year" do
          start = Time.parse("Sun Feb 01 12:15:12 UTC 2004")
          EqualityPredicate.new(:year, 2003).next_occurrence_after(start).should == nil
        end

        it "should return the beginning of the asserted year when value is greater than start.year" do
          start = Time.parse("Sun Feb 01 12:15:12 UTC 2004")
          next_time = Time.parse("Sun Jan 01 00:00:00 UTC 2006")
          start.should < next_time
          start.year.should < next_time.year
          EqualityPredicate.new(:year, 2006).next_occurrence_after(start).should == next_time
        end
      end
    end
  end
end
