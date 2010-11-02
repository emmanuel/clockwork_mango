require "spec_helper"

include ClockworkMango

describe ClockworkMango::ComparisonPredicate do
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
        it "should match #{klass} objects on asserted #{attr} integer value" do
          ComparisonPredicate.new(attr, value).should === @values[klass]
        end

        it "should match #{klass} objects on asserted #{attr} range value" do
          ComparisonPredicate.new(attr, (value - 1)..(value + 1)).should === @values[klass]
        end

        it "should not match #{klass} objects on any other #{attr} value" do
          ComparisonPredicate.new(attr, value - 1).should_not === @values[klass]
          ComparisonPredicate.new(attr, value + 1).should_not === @values[klass]
          ComparisonPredicate.new(attr, value + random).should_not === @values[klass]
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
          ComparisonPredicate.new(attr, value).should === @values[klass]
        end

        it "should match #{klass} objects on asserted #{attr} range value" do
          ComparisonPredicate.new(attr, (value - 1)..(value + 1)).should === @values[klass]
        end

        if specific
          it "should not match #{klass} objects on any other #{attr} value" do
            ComparisonPredicate.new(attr, value - 1).should_not === @values[klass]
            ComparisonPredicate.new(attr, value + 1).should_not === @values[klass]
            ComparisonPredicate.new(attr, value + random).should_not === @values[klass]
          end
        else
          it "should match #{klass} objects on any other #{attr} value" do
            ComparisonPredicate.new(attr, value - 1).should === @values[klass]
            ComparisonPredicate.new(attr, value + 1).should === @values[klass]
            ComparisonPredicate.new(attr, value + random).should === @values[klass]
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
          ComparisonPredicate.new(attr, value).should === @values[klass]
        end

        it "should match #{klass} objects on asserted #{attr} range value" do
          ComparisonPredicate.new(attr, (value - 1)..(value + 1)).should === @values[klass]
        end

        if specific
          it "should not match #{klass} objects on any other #{attr} value" do
            ComparisonPredicate.new(attr, value - 1).should_not === @values[klass]
            ComparisonPredicate.new(attr, value + 1).should_not === @values[klass]
            ComparisonPredicate.new(attr, value + random).should_not === @values[klass]
          end
        else
          it "should match #{klass} objects on any other #{attr} value" do
            ComparisonPredicate.new(attr, value - 1).should === @values[klass]
            ComparisonPredicate.new(attr, value + 1).should === @values[klass]
            ComparisonPredicate.new(attr, value + random).should === @values[klass]
          end
        end
      end
    end
  end

  describe "#next_occurrence" do
    before(:all) do
      @time = Time.parse("Sun Feb 01 00:00:00 UTC 2004")
    end

    it "should return a single Time object" do
      ComparisonPredicate.new(:day, 1).next_occurrence.should be_an_instance_of(Time)
    end

    it "should return an object representing the next occurrence of the receiver" do
      start = Time.parse("Sun Feb 01 00:00:00 UTC 2004")
      assertion = ComparisonPredicate.new(:day, 1)
      next_occurrence = Time.utc(start.year, start.month + 1, 1)
      assertion.next_occurrence(start).should == next_occurrence
    end

    it "should return a Time object that occurs after its argument" do
      start = Time.parse("Sun Feb 01 00:00:00 UTC 2004")
      assertion = ComparisonPredicate.new(:day, 1)
      assertion.next_occurrence(start).should > start
    end

    it "should return a Time object in the UTC zone with no argument" do
      ComparisonPredicate.new(:day, 1).next_occurrence.zone.should == "UTC"
    end

    it "should return a Time object with the same zone as its argument" do
      utc = Time.parse("Sun Feb 01 00:00:00 UTC 2004")
      ComparisonPredicate.new(:day, 1).next_occurrence(utc).zone.should == utc.zone
      local = Time.parse("Sun Feb 01 00:00:00 -0800 2004")
      ComparisonPredicate.new(:day, 1).next_occurrence(local).zone.should == local.zone
    end

    it "should return a temporal object of the same class as its argument" do
      date      = Date.parse("Mon Feb 01 00:00:00 UTC 2004")
      date_time = DateTime.parse("Mon Feb 01 00:00:00 UTC 2004")
      time      = Time.parse("Mon Feb 01 00:00:00 UTC 2004")
      assertion = ComparisonPredicate.new(:day, 1)

      assertion.next_occurrence(date).should      be_instance_of(Date)
      assertion.next_occurrence(date_time).should be_instance_of(DateTime)
      assertion.next_occurrence(time).should      be_instance_of(Time)
    end

    it "should return a value that matches the receiver" do
      start = Time.parse("Sun Feb 01 00:00:00 UTC 2004")
      assertion = ComparisonPredicate.new(:day, 1)
      assertion.should === assertion.next_occurrence
      assertion.should === assertion.next_occurrence(start)
    end

    it "should return 'Sun Feb 29 00:00:00 UTC 2004' when asked for the next 29th day after 'Sun Feb 01 00:00:00 UTC 2004'" do
      start = Time.parse("Sun Feb 01 00:00:00 UTC 2004")
      next_time = Time.parse("Sun Feb 29 00:00:00 UTC 2004")
      ComparisonPredicate.new(:day, 29).next_occurrence(start).should == next_time
    end

    it "should reset hours, minutes, and seconds when advancing day" do
      start = Time.parse("Sun Feb 01 12:15:12 UTC 2004")
      next_time = Time.parse("Sun Feb 29 00:00:00 UTC 2004")
      ComparisonPredicate.new(:day, 29).next_occurrence(start).should == next_time
    end

    it "should return a time within the current minute when a :sec value greater than start.sec is asserted" do
      start = Time.parse("Sun Feb 01 12:15:12 UTC 2004")
      next_time = Time.parse("Sun Feb 01 12:15:29 UTC 2004")
      start.sec.should < next_time.sec
      ComparisonPredicate.new(:sec, 29).next_occurrence(start).should == next_time
    end

    it "should return a time within the next minute when a :sec value less than start.sec is asserted" do
      start = Time.parse("Sun Feb 01 12:15:12 UTC 2004")
      next_time = Time.parse("Sun Feb 01 12:16:02 UTC 2004")
      start.sec.should > next_time.sec
      ComparisonPredicate.new(:sec, 2).next_occurrence(start).should == next_time
    end

    it "should return a time within the current hour when a :min value greater than start.min is asserted" do
      start = Time.parse("Sun Feb 01 12:15:12 UTC 2004")
      next_time = Time.parse("Sun Feb 01 12:18:00 UTC 2004")
      start.min.should < next_time.min
      ComparisonPredicate.new(:min, 18).next_occurrence(start).should == next_time
    end

    it "should return a time within the next hour when a :min value less than start.min is asserted" do
      start = Time.parse("Sun Feb 01 12:15:12 UTC 2004")
      next_time = Time.parse("Sun Feb 01 13:02:00 UTC 2004")
      start.min.should > next_time.min
      ComparisonPredicate.new(:min, 2).next_occurrence(start).should == next_time
    end

    it "should return a time within the current day when an :hour value greater than start.hour is asserted" do
      start = Time.parse("Sun Feb 01 12:15:12 UTC 2004")
      next_time = Time.parse("Sun Feb 01 16:00:00 UTC 2004")
      start.hour.should < next_time.hour
      ComparisonPredicate.new(:hour, 16).next_occurrence(start).should == next_time
    end

    it "should return a time within the next day when an :hour value less than start.hour is asserted" do
      start = Time.parse("Sun Feb 01 12:15:12 UTC 2004")
      next_time = Time.parse("Mon Feb 02 06:00:00 UTC 2004")
      start.hour.should > next_time.hour
      ComparisonPredicate.new(:hour, 6).next_occurrence(start).should == next_time
    end

    it "should return a time within the current month when a :day value greater than start.day is asserted" do
      start = Time.parse("Sun Feb 01 12:15:12 UTC 2004")
      next_time = Time.parse("Mon Feb 09 00:00:00 UTC 2004")
      start.day.should < next_time.day
      ComparisonPredicate.new(:day, 9).next_occurrence(start).should == next_time
    end

    it "should return a time within the next month when a :day value less than start.day is asserted" do
      start = Time.parse("Mon Feb 02 12:15:12 UTC 2004")
      next_time = Time.parse("Mon Mar 01 00:00:00 UTC 2004")
      start.day.should > next_time.day
      ComparisonPredicate.new(:day, 1).next_occurrence(start).should == next_time
    end

    it "should return a time within the current year when a :month value greater than start.month is asserted" do
      start = Time.parse("Sun Feb 01 12:15:12 UTC 2004")
      next_time = Time.parse("Mon Mar 01 00:00:00 UTC 2004")
      start.month.should < next_time.month
      ComparisonPredicate.new(:month, 3).next_occurrence(start).should == next_time
    end

    it "should return a time within the next year when a :month value less than start.month is asserted" do
      start = Time.parse("Mon Feb 02 12:15:12 UTC 2004")
      next_time = Time.parse("Sat Jan 01 00:00:00 UTC 2005")
      start.month.should > next_time.month
      ComparisonPredicate.new(:month, 1).next_occurrence(start).should == next_time
    end

    it "should return nil when a :year value less than start.year is asserted" do
      start = Time.parse("Sun Feb 01 12:15:12 UTC 2004")
      ComparisonPredicate.new(:year, 2003).next_occurrence(start).should == nil
    end

    it "should return the beginning of the asserted year when a :year value greater than start.year is asserted" do
      start = Time.parse("Sun Feb 01 12:15:12 UTC 2004")
      next_time = Time.parse("Sun Jan 01 00:00:00 UTC 2006")
      start.year.should < next_time.year
      ComparisonPredicate.new(:year, 2006).next_occurrence(start).should == next_time
    end
  end
end
