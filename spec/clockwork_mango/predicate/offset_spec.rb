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
    # 2010-11-25 is the 4th Thursday of November in 2010
    let(:matching_date) { DateTime.civil(2010, 11, 25) }
    let(:unit) { :days }
    let(:value) { 1 }

    subject { Predicate::Offset.new(predicate, unit, value) }

    it "should equal itself initialized with a singular" do
      singular_unit = unit.to_s.chomp("s").to_sym
      subject.should == Predicate::Offset.new(predicate, singular_unit, value)
    end

    context "when initialized with a positive value" do
      let(:value) { 1 }
      let(:offset_date) { matching_date + value }

      it { should be_kind_of(Predicate::Offset) }
      it { should express([:>>, predicate.to_temporal_sexp, unit, value]) }
      it { should === offset_date }
    end

    context "when initialized with a negative value" do
      let(:value) { -1 }
      let(:offset_date) { matching_date + value }

      it { should be_kind_of(Predicate::Offset) }
      it { should express([:>>, predicate.to_temporal_sexp, unit, value]) }
      it { should === offset_date }
    end

    context "when initialized with a zero value" do
      let(:value) { 0 }
      let(:offset_date) { matching_date + value }

      it { should be_kind_of(Predicate::Offset) }
      it { should express([:>>, predicate.to_temporal_sexp, unit, value]) }
      it { should === offset_date }
    end
  end
end
