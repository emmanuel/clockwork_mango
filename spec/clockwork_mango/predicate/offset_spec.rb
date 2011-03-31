require "spec_helper"
require "clockwork_mango/predicate/comparison"
require "clockwork_mango/predicate/compound"

module ClockworkMango
  describe Predicate::Offset do
    let(:predicate) {
      Predicate::Equality.new(:month, 11) &         # November
        Predicate::Equality.new(:wday, 4) &         # Thursday
        Predicate::Equality.new(:wday_in_month, 4)  # Fourth Thursday of the month
    }

    context "when initialized with a positive value" do
      subject { Predicate::Offset.new(predicate, :days, 1) }

      it { should be_kind_of(Predicate::Offset) }
      it { subject.should express([:>>, predicate.to_temporal_sexp, :days, 1]) }
      it "should equal itself initialized with a singular" do
        should == Predicate::Offset.new(predicate, :day, 1)
      end
      # 2010-11-25 is the 4th Thursday
      it { should === DateTime.parse("2010-11-26") }
    end

    context "when initialized with a negative value" do
      subject { Predicate::Offset.new(predicate, :days, -1) }

      it { should be_kind_of(Predicate::Offset) }
      it { subject.should express([:>>, predicate.to_temporal_sexp, :days, -1]) }
      it "should equal itself initialized with a singular" do
        should == Predicate::Offset.new(predicate, :day, -1)
      end
      # 2010-11-25 is the 4th Thursday
      it { should === DateTime.parse("2010-11-24") }
    end

    context "when initialized with a zero value" do
      subject { Predicate::Offset.new(predicate, :days, 0) }

      it { should be_kind_of(Predicate::Offset) }
      it { subject.should express([:>>, predicate.to_temporal_sexp, :days, 0]) }
      it "should equal itself initialized with a singular" do
        should == Predicate::Offset.new(predicate, :day, 0)
      end
      # 2010-11-25 was the 4th Thursday in November
      it { should === DateTime.parse("2010-11-25") }
    end
  end
end
