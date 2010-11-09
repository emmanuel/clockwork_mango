require "spec_helper"

module ClockworkMango
  describe CoreExt::HumanDateValues do
    describe "#leap_year?, #days_in_month, #days_in_year" do
      let(:leap_year_4yr)      { DateTime.new(2004, 2, 29) } # => Sun Feb 29 00:00:00 -0000 2004
      let(:no_leap_year_100yr) { DateTime.new(2100, 2, 28) } # => Sun Feb 28 00:00:00 -0000 2100
      let(:leap_year_400yr)    { DateTime.new(2000, 2, 29) } # => Tue Feb 29 00:00:00 -0000 2000

      context "on a 4yr leap year" do
        it "should correctly report the number of days in Feb of a 4yr leap year" do
          leap_year_4yr.leap_year?.should == true
          leap_year_4yr.days_in_month.should == 29
          leap_year_4yr.days_in_year.should == 366
        end
      end

      context "on a 100yr leap year" do
        it "should correctly report the number of days in Feb of a 100yr leap year" do
          no_leap_year_100yr.leap_year?.should == false
          no_leap_year_100yr.days_in_month.should == 28
          no_leap_year_100yr.days_in_year.should == 365
        end
      end

      context "on a 400yr leap year" do
        it "should correctly report the number of days in Feb" do
          leap_year_400yr.leap_year?.should == true
          leap_year_400yr.days_in_month.should == 29
          leap_year_400yr.days_in_year.should == 366
        end
      end
    end # describe "#leap_year?, #days_in_month, #days_in_year"


    end

    end
  end # describe CoreExt::HumanDateValues
end # module ClockworkMango
