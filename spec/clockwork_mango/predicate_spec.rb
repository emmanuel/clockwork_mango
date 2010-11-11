require "spec_helper"

module ClockworkMango
  describe Predicate do
    let(:time)     { Time.local(*TIME_ATTRIBUTES.map { |a| VALUES[a] }) }
    let(:datetime) { DateTime.new(*DATETIME_ATTRS.map { |a| VALUES[a] }) }
    let(:date)     { Date.new(*DATE_ATTRIBUTES.map { |a| VALUES[a] }) }

    let(:year)  { EqualityPredicate.new(:year, 2008) }
    let(:month) { EqualityPredicate.new(:month, 9) }
    let(:day)   { EqualityPredicate.new(:day, 24) }

    let(:hour) { EqualityPredicate.new(:hour, 18) }
    let(:min)  { EqualityPredicate.new(:min, 30) }
    let(:sec)  { EqualityPredicate.new(:sec, 15) }

    let(:yday)  { EqualityPredicate.new(:yday, 268) }
    let(:yweek) { EqualityPredicate.new(:day, 0) }
    let(:wday)  { EqualityPredicate.new(:wday, 3) }

    describe "#inspect" do
      it "should return itself as #to_temporal_expression" do
        year.inspect.should ==
          "<ClockworkMango::EqualityPredicate:#{year.object_id.to_s(16)} temporal_expression=#{year.to_temporal_expression.inspect}>"
      end
    end # describe "#inspect"

    describe "#|" do
      
    end # describe "#|"

    describe "#&" do
      
    end # describe "#&"

    describe "#-" do
      
    end # describe "#-"

    describe "#>>" do
      context "when called with a two element array" do
        subject { year >> [:years, 1] }

        it "should return an OffsetPredicate" do
          should be_kind_of(OffsetPredicate)
        end

        it "should be offsetted from the receiver" do
          should == OffsetPredicate.new(year, :years, 1)
        end
      end # context "when called with a two element array"
    end # describe "#>>"

  end # describe Predicate
end # module ClockworkMango
