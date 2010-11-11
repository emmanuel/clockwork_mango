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

    describe ".load" do
      context "when initializing with a simple expression" do
        subject { Predicate.load(:==, :wday, 4) }

        it "should return a Predicate object who's temporal expression is the same as it was initialized with" do
          subject.to_temporal_expression.should == [:==, :wday, 4]
          subject.should == EqualityPredicate.new(:wday, 4)
        end
      end
    end

    describe "#inspect" do
      it "should return itself as #to_temporal_expression" do
        year.inspect.should ==
          "<ClockworkMango::EqualityPredicate:#{year.object_id.to_s(16)} temporal_expression=#{year.to_temporal_expression.inspect}>"
      end
    end # describe "#inspect"

    describe "#|" do
      subject { year | Dsl.month(0..6) }

      it { should be_kind_of(UnionPredicate) }

      it "should be unioned with the receiver" do
        should == UnionPredicate.new(year, Dsl.month(0..6))
      end
    end # describe "#|"

    describe "#&" do
      subject { year & Dsl.month(0..6) }

      it { should be_kind_of(IntersectionPredicate) }

      it "should be intersected with the receiver" do
        should == IntersectionPredicate.new(year, Dsl.month(0..6))
      end
    end # describe "#&"

    describe "#-" do
      subject { year - Dsl.month(0..6) }

      it { should be_kind_of(DifferencePredicate) }

      it "should be a DifferencePredicate of the receiver and the arg" do
        should == DifferencePredicate.new(year, Dsl.month(0..6))
      end
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
