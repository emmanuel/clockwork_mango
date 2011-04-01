require "spec_helper"
require "clockwork_mango/predicate/comparison"

module ClockworkMango
  describe Predicate::Comparison do
    let(:date)      { Date.new(*DATE_ATTRIBUTES.map { |a| VALUES[a] }) }
    let(:datetime)  { DateTime.new(*DATETIME_ATTRS.map { |a| VALUES[a] }) }
    let(:time)      { Time.local(*TIME_ATTRIBUTES.map { |a| VALUES[a] }) }
    let(:values)    { { Date => date, DateTime => datetime, Time => time } }

    describe "DAY_PRECISION_UNITS" do
      DAY_PRECISION_UNITS.each do |attr|
        value = VALUES[attr]
        random = rand(99)

        [::Time, ::DateTime, ::Date].each do |klass|
          it "should match #{klass}s on asserted #{attr} integer value" do
            Predicate::Equality.new(attr, value).should === values[klass]
          end

          it "should match #{klass}s on asserted #{attr} range value" do
            Predicate::Inclusion.new(attr, (value - 1)..(value + 1)).should === values[klass]
          end

          it "should not match #{klass}s on any other #{attr} value" do
            Predicate::Equality.new(attr, value - 1).should_not === values[klass]
            Predicate::Equality.new(attr, value + 1).should_not === values[klass]
            Predicate::Equality.new(attr, value + random).should_not === values[klass]
          end
        end
      end
    end # describe DAY_PRECISION_UNITS

    describe "SECOND_PRECISION_UNITS" do
      (SECOND_PRECISION_UNITS - DAY_PRECISION_UNITS).each do |attr|
        value = VALUES[attr]
        random = rand(99)

        {::Time => true, ::DateTime => true, ::Date => false}.each do |klass, specific|
          it "should match #{klass} objects on asserted #{attr} integer value" do
            Predicate::Equality.new(attr, value).should === values[klass]
          end

          it "should match #{klass} objects on asserted #{attr} range value" do
            Predicate::Inclusion.new(attr, (value - 1)..(value + 1)).should === values[klass]
          end

          if specific
            it "should not match #{klass} objects on any other #{attr} value" do
              Predicate::Equality.new(attr, value - 1).should_not === values[klass]
              Predicate::Equality.new(attr, value + 1).should_not === values[klass]
              Predicate::Equality.new(attr, value + random).should_not === values[klass]
            end
          else
            it "should match #{klass} objects on any other #{attr} value" do
              Predicate::Equality.new(attr, value - 1).should === values[klass]
              Predicate::Equality.new(attr, value + 1).should === values[klass]
              Predicate::Equality.new(attr, value + random).should === values[klass]
            end
          end
        end
      end
    end # describe SECOND_PRECISION_UNITS

    describe "USECOND_PRECISION_UNITS" do
      (USECOND_PRECISION_UNITS - SECOND_PRECISION_UNITS).each do |attr|
        value = VALUES[attr]
        random = rand(99)

        {::Time => true, ::DateTime => false, ::Date => false}.each do |klass, specific|
          it "should match #{klass} objects on asserted #{attr} integer value" do
            Predicate::Equality.new(attr, value).should === values[klass]
          end

          it "should match #{klass} objects on asserted #{attr} range value" do
            Predicate::Inclusion.new(attr, (value - 1)..(value + 1)).should === values[klass]
          end

          if specific
            it "should not match #{klass} objects on any other #{attr} value" do
              Predicate::Equality.new(attr, value - 1).should_not === values[klass]
              Predicate::Equality.new(attr, value + 1).should_not === values[klass]
              Predicate::Equality.new(attr, value + random).should_not === values[klass]
            end
          else
            it "should match #{klass} objects on any other #{attr} value" do
              Predicate::Equality.new(attr, value - 1).should === values[klass]
              Predicate::Equality.new(attr, value + 1).should === values[klass]
              Predicate::Equality.new(attr, value + random).should === values[klass]
            end
          end
        end
      end
    end # describe "USECOND_PRECISION_UNITS"

    describe "#to_temporal_sexp" do
      ClockworkMango::Constants::COMPARABLE_ATTRIBUTES.each do |attribute|
        context ":#{attribute} Predicate::Equalitys" do
          (0..4).each do |value|
            context "with value #{value}" do
              describe Predicate::Comparison do
                it "should return [:===, :#{attribute}, #{value}]" do
                  predicate = Predicate::Comparison.new(attribute, value)
                  predicate.to_temporal_sexp.should == [:===, attribute, value]
                end
              end

              describe Predicate::Equality do
                it "should return [:==, :#{attribute}, #{value}] with value #{value}" do
                  predicate = Predicate::Equality.new(attribute, value)
                  predicate.to_temporal_sexp.should == [:==, attribute, value]
                end
              end

              describe Predicate::Inclusion do
                it "should return [:include?, :#{attribute}, #{value}] with value #{value}" do
                  range = value..(value + 3)
                  predicate = Predicate::Inclusion.new(attribute, range)
                  predicate.to_temporal_sexp.should == [:include?, attribute, range]
                end
              end

              describe Predicate::Exclusion do
                it "should return [:exclude?, :#{attribute}, #{value}] with value #{value}" do
                  range = value..(value + 3)
                  predicate = Predicate::Exclusion.new(attribute, range)
                  predicate.to_temporal_sexp.should == [:exclude?, attribute, range]
                end
              end

              describe Predicate::GreaterThan do
                it "should return [:>, :#{attribute}, #{value}] with value #{value}" do
                  predicate = Predicate::GreaterThan.new(attribute, value)
                  predicate.to_temporal_sexp.should == [:>, attribute, value]
                end
              end

              describe Predicate::LessThan do
                it "should return [:<, :#{attribute}, #{value}] with value #{value}" do
                  predicate = Predicate::LessThan.new(attribute, value)
                  predicate.to_temporal_sexp.should == [:<, attribute, value]
                end
              end
            end
          end
        end
      end # Constants::COMPARABLE_ATTRIBUTES
    end # describe "#to_temporal_sexp"
  end # describe Predicate::Comparison
end # module ClockworkMango
