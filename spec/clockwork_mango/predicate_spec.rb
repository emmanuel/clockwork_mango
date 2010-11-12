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
          subject.should express([:==, :wday, 4])
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
      let(:predicate) { InclusionPredicate.new(:month, 0..6) }
      subject { year | predicate }

      it { should be_kind_of(UnionPredicate) }
      it { should express(UnionPredicate.new(year, predicate)) }
    end # describe "#|"

    describe "#&" do
      let(:predicate) { InclusionPredicate.new(:month, 0..6) }
      subject { year & predicate }

      it { should be_kind_of(IntersectionPredicate) }
      it { should express(IntersectionPredicate.new(year, predicate)) }
    end # describe "#&"

    describe "#-" do
      let(:predicate) { InclusionPredicate.new(:month, 0..6) }
      subject { year - predicate }

      it { should be_kind_of(DifferencePredicate) }
      it { should express(DifferencePredicate.new(year, predicate)) }
    end # describe "#-"

    describe "#>>" do
      context "when called with a two element array" do
        subject { year >> [:years, 1] }

        it { should be_kind_of(OffsetPredicate) }
        it { should express(OffsetPredicate.new(year, :years, 1)) }
      end # context "when called with a two element array"
    end # describe "#>>"

  end # describe Predicate
end # module ClockworkMango
