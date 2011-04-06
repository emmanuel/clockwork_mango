require "spec_helper"
require "clockwork_mango/predicate/comparison"
require "clockwork_mango/predicate/compound"

module ClockworkMango
  describe Predicate::Intersection do
    let(:time)     { Time.local(2008, 9, 24, 18, 30, 15, 500) }
    let(:datetime) { time.to_datetime }
    let(:date)     { time.to_date }

    let(:year_08) { Predicate::Equality.new(:year, 2008) }
    let(:mday)    { Predicate::Equality.new(:mday, 24) }

    subject { Predicate::Intersection.new(year_08, mday) }

    it "should match Times when both expressions match" do
      should === time
    end

    it "should match DateTimes when both expressions match" do
      should === datetime
    end

    it "should match Dates when both expressions match" do
      should === date
    end

    it "should not match Times when one expression does not match" do
      should_not === (time + (1 * 24 * 60 * 60))
    end

    it "should not match Dates when one expression does not match" do
      should_not === (datetime + 1)
    end

    it "should not match Dates when one expression does not match" do
      should_not === (date + 1)
    end
  end # describe Predicate::Intersection
end
