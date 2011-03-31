require "spec_helper"
require "clockwork_mango/predicate/comparison"
require "clockwork_mango/predicate/compound"

module ClockworkMango
  describe Predicate::Intersection do
    let(:year_08) { Predicate::Equality.new(:year, 2008) }
    let(:day)    { Predicate::Equality.new(:day, 24) }

    let(:time)     { Time.local(*TIME_ATTRIBUTES.map { |a| VALUES[a] }) }
    let(:datetime) { DateTime.new(*DATETIME_ATTRS.map { |a| VALUES[a] }) }
    let(:date)     { Date.new(*DATE_ATTRIBUTES.map { |a| VALUES[a] }) }

    subject { Predicate::Intersection.new(year_08, day) }

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
