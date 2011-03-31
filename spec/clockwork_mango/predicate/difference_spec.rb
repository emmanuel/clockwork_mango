require "spec_helper"
require "clockwork_mango/predicate/comparison"
require "clockwork_mango/predicate/compound"

module ClockworkMango
  describe Predicate::Difference do
    let(:time)     { Time.local(*TIME_ATTRIBUTES.map { |a| VALUES[a] }) }
    let(:datetime) { DateTime.new(*DATETIME_ATTRS.map { |a| VALUES[a] }) }
    let(:date)     { Date.new(*DATE_ATTRIBUTES.map { |a| VALUES[a] }) }

    let(:year_08) { Predicate::Equality.new(:year, 2008) }
    let(:year_07) { Predicate::Equality.new(:year, 2007) }

    subject { Predicate::Difference.new(year_08, year_07) }

    it "should match Times when the 1st expression matches and the 2nd doesn't" do
      should === time
    end

    it "should match DateTimes when the 1st expression matches and the 2nd doesn't" do
      should === datetime
    end

    it "should match Dates when the 1st expression matches and the 2nd doesn't" do
      should === date
    end

    it "should not match Dates when the 1st expression matches and the 2nd does, too"

    it "should not match Dates when the 1st expression doesn't match and the 2nd one does" do
      should_not === (date - 365)
    end
  end # describe Predicate::Difference

end
