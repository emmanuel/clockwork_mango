require 'spec_helper'
require "clockwork_mango/occurrence_solver"
require "clockwork_mango/predicate"
require "clockwork_mango/predicate/comparison"

module ClockworkMango
  describe OccurrenceSolver::Comparison do
    describe "#next_occurrence" do
      let(:start)     { Time.utc(2004, 2, 1, 12, 15, 12) }
      let(:next_29th) { Time.utc(2004, 2, 29) }
      let(:date)      { Date.new(2004, 2, 1) }
      let(:date_time) { DateTime.new(2004, 2, 1, 12, 15, 12) }
      let(:time)      { start }
      let(:day_1)     { Predicate::Equality.new(:day, 1) }
      let(:day_29)    { Predicate::Equality.new(:day, 29) }

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
        subject { predicate.next_occurrence(@given_time) }

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
        day_1.next_occurrence(date).should      be_instance_of(Date)
        day_1.next_occurrence(date_time).should be_instance_of(DateTime)
        day_1.next_occurrence(time).should      be_instance_of(Time)
      end

      it "should return a value that matches the receiver" do
        day_1.should === day_1.next_occurrence(start)
      end

      context "when @attribute is :sec" do
        it "should return a time within the current minute when value is greater than start.sec" do
          next_time = Time.utc(2004, 2, 1, 12, 15, 29)
          start.should < next_time
          start.sec.should < next_time.sec
          Predicate::Equality.new(:sec, 29).next_occurrence(start).should == next_time
        end

        it "should return a time within the next minute when value is less than start.sec" do
          next_time = Time.utc(2004, 2, 1, 12, 16, 02)
          start.should < next_time
          start.sec.should > next_time.sec
          Predicate::Equality.new(:sec, 2).next_occurrence(start).should == next_time
        end
      end

      context "when @attribute is :min" do
        it "should return a time within the current hour when value is greater than start.min" do
          next_time = Time.utc(2004, 2, 1, 12, 18)
          start.should < next_time
          start.min.should < next_time.min
          Predicate::Equality.new(:min, 18).next_occurrence(start).should == next_time
        end

        it "should return a time within the next hour when value is less than start.min" do
          next_time = Time.utc(2004, 2, 1, 13, 2)
          start.should < next_time
          start.min.should > next_time.min
          Predicate::Equality.new(:min, 2).next_occurrence(start).should == next_time
        end
      end

      context "when @attribute is :hour" do
        it "should return a time within the current day when value is greater than start.hour" do
          next_time = Time.utc(2004, 2, 1, 16)
          start.should < next_time
          start.hour.should < next_time.hour
          Predicate::Equality.new(:hour, 16).next_occurrence(start).should == next_time
        end

        it "should return a time within the next day when value is less than start.hour" do
          next_time = Time.utc(2004, 2, 2, 6)
          start.should < next_time
          start.hour.should > next_time.hour
          Predicate::Equality.new(:hour, 6).next_occurrence(start).should == next_time
        end
      end

      context "when @attribute is :day" do
        it "should return 'Sun Feb 29 00:00:00 UTC 2004' when asked for the next 29th day after 'Sun Feb 01 00:00:00 UTC 2004'" do
          day_29.next_occurrence(start).should == next_29th
        end

        it "should reset hours, minutes, and seconds when advancing day" do
          start = Time.utc(2004, 2, 1, 12, 15, 12)
          day_29.next_occurrence(start).should == next_29th
        end

        it "should return a time within the current month when value is greater than start.day" do
          next_time = Time.utc(2004, 2, 9)
          start.should < next_time
          start.day.should < next_time.day
          Predicate::Equality.new(:day, 9).next_occurrence(start).should == next_time
        end

        it "should return a time within the next month when value is less than start.day" do
          start = Time.utc(2004, 2, 15)
          next_time = Time.utc(2004, 3, 1)
          start.should < next_time
          start.day.should > next_time.day
          day_1.next_occurrence(start).should == next_time
        end
      end

      context "when @attribute is :month" do
        it "should return a time within the current year when value is greater than start.month" do
          next_time = Time.utc(2004, 3, 1)
          start.should < next_time
          start.month.should < next_time.month
          Predicate::Equality.new(:month, 3).next_occurrence(start).should == next_time
        end

        it "should return a time within the next year when value is less than start.month" do
          next_time = Time.utc(2005, 1, 1)
          start.should < next_time
          start.month.should > next_time.month
          Predicate::Equality.new(:month, 1).next_occurrence(start).should == next_time
        end
      end

      context "when @attribute is :year" do
        let(:next_time) { Time.utc(2006, 1, 1, 00, 00, 00) }

        it "should return nil when value is less than start.year" do
          Predicate::Equality.new(:year, 2003).next_occurrence(start).should == nil
        end

        it "should return the beginning of the asserted year when value is greater than start.year" do
          start.should < next_time
          start.year.should < next_time.year
          Predicate::Equality.new(:year, 2006).next_occurrence(start).should == next_time
        end
      end
    end # describe '#next_occurrence'
  end # describe OccurrenceSolver::Comparison

  describe OccurrenceSolver::Union do
    describe '#next_occurrence' do
      let(:union) { Predicate::Union.new(*predicates) }
      subject { union.next_occurrence(after_time) }

      context 'when predicates are for month: 7, day: 15' do
        let(:predicates) { [
          Predicate::Equality.new(:month,  7),
          Predicate::Equality.new(:day,   15),
        ] }

        context "when after Mar 25, 2011" do
          let(:after_time) { Date.civil(2011, 3, 25) }
          it 'returns Apr 15, 2011' do
            subject.should == Date.civil(2011, 4, 15)
          end
        end

        context "when after Apr 20, 2011" do
          let(:after_time) { Date.civil(2011, 4, 20) }
          it 'returns May 15, 2011' do
            subject.should == Date.civil(2011, 5, 15)
          end
        end

        context "when after May 20, 2011" do
          let(:after_time) { Date.civil(2011, 5, 20) }
          it 'returns Jun 15, 2011' do
            subject.should == Date.civil(2011, 6, 15)
          end
        end

        context "when after Jun 20, 2011" do
          let(:after_time) { Date.civil(2011, 6, 20) }
          it 'returns Jul 1, 2011' do
            subject.should == Date.civil(2011, 7, 1)
          end
        end

        context "when after Jul 1, 2011" do
          let(:after_time) { Date.civil(2011, 7, 1) }
          it 'returns Jul 15, 2011' do
            subject.should == Date.civil(2011, 7, 15)
          end
        end
      end
    end # describe '#next_occurrence'
  end # describe OccurrenceSolver::Union
end # module ClockworkMango
