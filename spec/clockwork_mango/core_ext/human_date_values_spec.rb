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

    describe "#yweek" do
      it "should return 0 when called before the first Sunday of the year" do
        DateTime.parse("2011-01-01").yweek.should == 0
      end

      it "should return 1 when called after the first Sunday of the year, before the second" do
        DateTime.parse("2011-01-03").yweek.should == 1
      end

      it "should return 8 when called on 2004-02-29" do
        DateTime.parse("2004-02-29").yweek.should == 8
      end

      it "should return 44 when called on 2010-11-08" do
        DateTime.parse("2010-11-08").yweek.should == 44
      end
    end

    end
  end # describe CoreExt::HumanDateValues
end # module ClockworkMango
