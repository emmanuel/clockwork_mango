require "spec_helper"
require "clockwork_mango/predicate/comparison"
require "clockwork_mango/predicate/compound"

module ClockworkMango
  describe Predicate::Union do
    let(:time)     { Time.local(*TIME_ATTRIBUTES.map { |a| VALUES[a] }) }
    let(:datetime) { DateTime.new(*DATETIME_ATTRS.map { |a| VALUES[a] }) }
    let(:date)     { Date.new(*DATE_ATTRIBUTES.map { |a| VALUES[a] }) }
    let(:time_in_06) { DateTime.civil(2006, 6, 1, 12, 0, 0) }

    let(:year_08) { Predicate::Equality.new(:year, 2008) }
    let(:year_06) { Predicate::Equality.new(:year, 2006) }

    subject { Predicate::Union.new(year_08, year_06) }

    it "should match Times when either expression matches" do
      should === time
    end

    it "should match DateTimes when either expression matches" do
      should === datetime
    end

    it "should match Dates when either expression matches" do
      should === date
    end

    it "should match DateTimes when either expression matches" do
      should === time_in_06
    end

    it "should not match Times when neither expression matches" do
      should_not === (time + (365 * 24 * 60 * 60))
    end

    it "should not match DateTimes when neither expression matches" do
      should_not === (time_in_06 - (365 * 24 * 60 * 60))
    end
  end # describe Predicate::Union
end # module ClockworkMango
