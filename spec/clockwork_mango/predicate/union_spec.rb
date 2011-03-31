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

    describe '#next_occurrence' do
      let(:union) { Predicate::Union.new(*predicates) }
      subject { union.next_occurrence(after_time) }

      context 'when predicates are for month: 7, day: 15' do
        let(:predicates) { [
          Predicate::Equality.new(:month,  7),
          Predicate::Equality.new(:day,   15),
        ] }

        context "when after Mar 25, 2011" do
          let(:after_time) { Date.civil(2011, 3, 25) }
          it 'returns Apr 15, 2011' do
            subject.should == Date.civil(2011, 4, 15)
          end
        end

        context "when after Apr 20, 2011" do
          let(:after_time) { Date.civil(2011, 4, 20) }
          it 'returns May 15, 2011' do
            subject.should == Date.civil(2011, 5, 15)
          end
        end

        context "when after May 20, 2011" do
          let(:after_time) { Date.civil(2011, 5, 20) }
          it 'returns Jun 15, 2011' do
            subject.should == Date.civil(2011, 6, 15)
          end
        end

        context "when after Jun 20, 2011" do
          let(:after_time) { Date.civil(2011, 6, 20) }
          it 'returns Jul 1, 2011' do
            subject.should == Date.civil(2011, 7, 1)
          end
        end

        context "when after Jul 1, 2011" do
          let(:after_time) { Date.civil(2011, 7, 1) }
          it 'returns Jul 15, 2011' do
            subject.should == Date.civil(2011, 7, 15)
          end
        end
      end

    end # describe '#next_occurrence'
  end # describe Predicate::Union
end
