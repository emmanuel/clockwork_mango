require "spec_helper"
require "clockwork_mango/predicate/base"
require "clockwork_mango/predicate/comparison"

module ClockworkMango
  describe Predicate::Base do
    let(:time)     { Time.local(*TIME_ATTRIBUTES.map { |a| VALUES[a] }) }
    let(:datetime) { DateTime.new(*DATETIME_ATTRS.map { |a| VALUES[a] }) }
    let(:date)     { Date.new(*DATE_ATTRIBUTES.map { |a| VALUES[a] }) }

    let(:year)  { Predicate::Equality.new(:year, 2008) }
    let(:month) { Predicate::Equality.new(:month, 9) }
    let(:day)   { Predicate::Equality.new(:day, 24) }

    let(:hour) { Predicate::Equality.new(:hour, 18) }
    let(:min)  { Predicate::Equality.new(:min, 30) }
    let(:sec)  { Predicate::Equality.new(:sec, 15) }

    let(:yday)  { Predicate::Equality.new(:yday, 268) }
    let(:yweek) { Predicate::Equality.new(:day, 0) }
    let(:wday)  { Predicate::Equality.new(:wday, 3) }

    describe ".load" do
      context "when initializing with a simple expression" do
        subject { Predicate.load(:==, :wday, 4) }

        it "should return a Predicate object who's temporal expression is the same as it was initialized with" do
          subject.should express([:==, :wday, 4])
          subject.should == Predicate::Equality.new(:wday, 4)
        end
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
