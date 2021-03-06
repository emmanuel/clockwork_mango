require "spec_helper"
require "clockwork_mango/loader"
require "clockwork_mango/dsl"

module ClockworkMango
  describe Loader do
    context "with simple expressions" do
      describe :== do
        subject { Loader.load_expression(:==, :month, 11) }

        it { should be_kind_of(Predicate::Equality) }
        it { subject.should express([:==, :month, 11]) }
      end # describe :==

      describe :| do
        subject { Loader.load_expression(:|, [:==, :month, 11], [:==, :wday, 4]) }

        it { should be_kind_of(Predicate::Union) }
        it "should de-serialize two sub-expressions correctly" do
          subject.should express([:|, [:==, :month, 11], [:==, :wday, 4]])
        end

        it "should de-serialize three sub-expressions correctly" do
          Loader.load_expression(:|, [:==, :hour, 9], [:==, :min, 15], [:==, :sec, 30]).should ==
            Dsl.hour(9) | Dsl.min(15) | Dsl.sec(30)
        end
      end # describe :|

      describe :& do
        subject { Loader.load_expression(:&, [:==, :month, 11], [:==, :wday, 4]) }

        it { should be_kind_of(Predicate::Intersection) }

        it "should de-serialize two sub-expressions correctly" do
          subject.should express([:&, [:==, :month, 11], [:==, :wday, 4]])
        end

        it "should de-serialize three sub-expressions correctly" do
          Loader.load_expression(:&, [:==, :hour, 9], [:==, :min, 15], [:==, :sec, 30]).should == Dsl.at(9,15,30)
        end
      end # describe :&

      describe :>> do
        subject { Loader.load_expression(:>>, [:==, :month, 11], :wdays, 4) }

        it { should be_kind_of(Predicate::Offset) }

        it "should de-serialize one sub-expression correctly" do
          subject.should express([:>>, [:==, :month, 11], :wdays, 4])
        end
      end # describe :>>
    end # context "with simple expressions"

    context "with complex expressions" do
      context "#from(9,15,30)" do
        subject { Loader.load_expression(:|, [:>, :hour, 9], [:&, [:==, :hour, 9], [:|, [:>, :min, 15], [:&, [:==, :min, 15], [:>=, :sec, 30]]]]) }

        it "should de-serialize correctly" do
          subject.should express([:|,
            [:>, :hour, 9],
            [:&,
              [:==, :hour, 9],
              [:|,
                [:>, :min, 15],
                [:&,
                  [:==, :min, 15],
                  [:>=, :sec, 30]]]]])
        end
      end # context "when nested one layer deep"
    end # context "with complex expressions"
  end # describe Loader
end # module ClockworkMango
