require "spec_helper"
require "clockwork_mango/occurrence_solver/comparison"
require "clockwork_mango/predicate"
require "clockwork_mango/predicate/comparison"

module ClockworkMango
  describe OccurrenceSolver::Equality do
    describe "#next_occurrence" do
      let(:start)     { Time.utc(2004, 2, 1, 12, 15, 12) }
      let(:next_29th) { Time.utc(2004, 2, 29) }
      let(:date)      { Date.new(2004, 2, 1) }
      let(:date_time) { DateTime.new(2004, 2, 1, 12, 15, 12) }
      let(:time)      { start }
      let(:mday_1)    { Predicate::Equality.new(:mday, 1) }
      let(:mday_29)   { Predicate::Equality.new(:mday, 29) }

      context "with no arguments" do
        it "should return a single Time object" do
          mday_1.next_occurrence.should be_an_instance_of(Time)
        end

        it "should return a value that matches the receiver" do
          mday_1.should === mday_1.next_occurrence
        end
      end

      context "with a single Time argument" do
        let(:predicate)  { mday_1 }
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
        solver = OccurrenceSolver::Equality.new(mday_1)
        solver.next_occurrence(date).should      be_instance_of(Date)
        solver.next_occurrence(date_time).should be_instance_of(DateTime)
        solver.next_occurrence(time).should      be_instance_of(Time)
      end

      it "should return a value that matches the receiver" do
        mday_1.should === mday_1.next_occurrence(start)
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

      context "when @attribute is :mday" do
        it "should return 'Sun Feb 29 00:00:00 UTC 2004' when asked for the next 29th day after 'Sun Feb 01 00:00:00 UTC 2004'" do
          mday_29.next_occurrence(start).should == next_29th
        end

        it "should reset hours, minutes, and seconds when advancing day" do
          start = Time.utc(2004, 2, 1, 12, 15, 12)
          mday_29.next_occurrence(start).should == next_29th
        end

        it "should return a time within the current month when value is greater than start.day" do
          next_time = Time.utc(2004, 2, 9)
          start.should < next_time
          start.day.should < next_time.day
          predicate = Predicate::Equality.new(:mday, 9)
          solver = OccurrenceSolver::Equality.new(predicate)
          solver.next_occurrence(start).should == next_time
        end

        it "should return a time within the next month when value is less than start.day" do
          start = Time.utc(2004, 2, 15)
          next_time = Time.utc(2004, 3, 1)
          start.should < next_time
          start.day.should > next_time.day
          mday_1.next_occurrence(start).should == next_time
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
end # module ClockworkMango
