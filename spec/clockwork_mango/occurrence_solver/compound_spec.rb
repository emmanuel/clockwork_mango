require "spec_helper"
require "clockwork_mango/occurrence_solver/compound"

module ClockworkMango
  describe OccurrenceSolver::Union do
    describe '#next_occurrence' do
      let(:union) { Predicate::Union.new(*predicates) }
      subject { union.next_occurrence(after_time) }

      context 'when predicates are for month: 7, day: 15' do
        let(:predicates) { [
          Predicate::Equality.new(:month,  7),
          Predicate::Equality.new(:mday,   15),
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
  end # describe OccurrenceSolver::Union
end # module ClockworkMango
