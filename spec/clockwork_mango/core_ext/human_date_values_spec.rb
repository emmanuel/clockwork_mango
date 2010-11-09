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
        DateTime.parse("2010-11-08").yweek.should == 45
      end
    end # describe "#yweek"

    describe "#yweek_reverse" do
      it "should return 52 when called on 2011-01-01" do
        DateTime.parse("2011-01-01").yweek_reverse.should == 52
      end

      it "should return 7 when called on 2010-11-08" do
        DateTime.parse("2010-11-08").yweek_reverse.should == 7
      end

      it "should return 3 when called on 2010-12-08" do
        DateTime.parse("2010-12-08").yweek_reverse.should == 3
      end
    end # describe "#yweek_reverse"

    describe "#mweek" do
      it "should return 0 when called before the first Sunday of the month" do
        DateTime.parse("2011-01-01").mweek.should == 0
      end

      it "should return 1 when called after the first Sunday of the month, before the second" do
        DateTime.parse("2011-01-03").mweek.should == 1
      end

      it "should return 4 when called on 2004-02-29" do
        DateTime.parse("2004-02-29").mweek.should == 4
      end

      it "should return 1 when called on 2010-11-08" do
        DateTime.parse("2010-11-08").mweek.should == 1
      end

      it "should return 2 when called on 2010-11-18" do
        DateTime.parse("2010-11-18").mweek.should == 2
      end
    end # describe "#mweek"

    describe "#mweek_reverse" do
      it "should return 5 when called on 2011-01-01" do
        DateTime.parse("2011-01-01").mweek_reverse.should == 5
      end

      it "should return 4 when called on 2011-01-03" do
        DateTime.parse("2011-01-03").mweek_reverse.should == 4
      end

      it "should return 0 when called on 2004-02-29" do
        DateTime.parse("2004-02-29").mweek_reverse.should == 0
      end

      it "should return 3 when called on 2010-11-08" do
        DateTime.parse("2010-11-08").mweek_reverse.should == 3
      end

      it "should return 2 when called on 2010-11-18" do
        DateTime.parse("2010-11-18").mweek_reverse.should == 2
      end
    end # describe "#mweek_reverse"

    describe "#wday_in_month" do
      it "should return 1 when called on 2011-01-01" do
        DateTime.parse("2011-01-01").wday_in_month.should == 1
      end

      it "should return 1 when called on 2011-01-03" do
        DateTime.parse("2011-01-03").wday_in_month.should == 1
      end

      it "should return 5 when called on 2004-02-29" do
        DateTime.parse("2004-02-29").wday_in_month.should == 5
      end

      it "should return 2 when called on 2010-11-08" do
        DateTime.parse("2010-11-08").wday_in_month.should == 2
      end
    end # describe "#wday_in_month"

    describe "#wday_in_month_reverse" do
      it "should return 4 when called on 2011-01-01" do
        DateTime.parse("2011-01-01").wday_in_month_reverse.should == 4
      end

      it "should return 4 when called on 2011-01-03" do
        DateTime.parse("2011-01-03").wday_in_month_reverse.should == 4
      end

      it "should return 0 when called on 2004-02-29" do
        DateTime.parse("2004-02-29").wday_in_month_reverse.should == 0
      end

      it "should return 3 when called on 2010-11-08" do
        DateTime.parse("2010-11-08").wday_in_month_reverse.should == 3
      end

      it "should return 1 when called on 2010-11-18" do
        DateTime.parse("2010-11-18").wday_in_month_reverse.should == 1
      end
    end # describe "#wday_in_month_reverse"
  end # describe CoreExt::HumanDateValues
end # module ClockworkMango
