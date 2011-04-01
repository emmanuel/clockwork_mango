require "spec_helper"
require "clockwork_mango/predicate/base"
require "clockwork_mango/predicate/comparison"
require "clockwork_mango/loader"

module ClockworkMango
  describe Predicate::Base do
    let(:time)     { Time.local(2008, 9, 24, 18, 30, 15, 500) }
    let(:datetime) { time.to_datetime }
    let(:date)     { time.to_date }

    let(:year)  { Predicate::Equality.new(:year, 2008) }
    let(:month) { Predicate::Equality.new(:month, 9) }
    let(:day)   { Predicate::Equality.new(:day, 24) }

    let(:hour) { Predicate::Equality.new(:hour, 18) }
    let(:min)  { Predicate::Equality.new(:min, 30) }
    let(:sec)  { Predicate::Equality.new(:sec, 15) }

    let(:yday)  { Predicate::Equality.new(:yday, 268) }
    let(:yweek) { Predicate::Equality.new(:day, 0) }
    let(:wday)  { Predicate::Equality.new(:wday, 3) }

    describe ".load_expression" do
      it "should delegate to ClockworkMango::Loader.load_expression" do
        expression = yday.to_temporal_sexp
        Loader.should_receive(:load_expression).with(expression)
        Predicate.load_expression(expression)
      end
    end

    describe "#inspect" do
      it "should return itself as #to_temporal_sexp" do
        year.inspect.should ==
          "<#{year.class.to_s}:#{year.object_id.to_s(16)} expression=#{year.to_temporal_sexp.inspect}>"
      end
    end # describe "#inspect"

    describe "#|" do
      let(:predicate) { Predicate::Inclusion.new(:month, 0..6) }
      subject { year | predicate }

      it { should be_kind_of(Predicate::Union) }
      it { should express(Predicate::Union.new(year, predicate)) }
    end # describe "#|"

    describe "#&" do
      let(:predicate) { Predicate::Inclusion.new(:month, 0..6) }
      subject { year & predicate }

      it { should be_kind_of(Predicate::Intersection) }
      it { should express(Predicate::Intersection.new(year, predicate)) }
    end # describe "#&"

    describe "#-" do
      let(:predicate) { Predicate::Inclusion.new(:month, 0..6) }
      subject { year - predicate }

      it { should be_kind_of(Predicate::Difference) }
      it { should express(Predicate::Difference.new(year, predicate)) }
    end # describe "#-"

    describe "#>>" do
      context "when called with a two element array" do
        subject { year >> [:years, 1] }

        it { should be_kind_of(Predicate::Offset) }
        it { should express(Predicate::Offset.new(year, :years, 1)) }
      end # context "when called with a two element array"
    end # describe "#>>"

  end # describe Predicate::Base
end # module ClockworkMango
