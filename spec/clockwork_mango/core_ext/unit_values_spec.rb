require "spec_helper"
require "clockwork_mango/core_ext/unit_values"

describe ClockworkMango::CoreExt::UnitValues do
  TOLERANCE = 0.000000001   # floats get reeeaally close

  describe "Date units" do
    before :all do
      @date     = Date.today
      @datetime = DateTime.now
    end

    it "should raise ArgumentError if an invalid unit is provided" do
      lambda { Date.unit_value(:bogus_unit, 1.0) }.should raise_error(ArgumentError)
    end

    it "should convert seconds as a float fraction of days" do
      Date.unit_value(:second, 10).should be_within(TOLERANCE).of(10.0 / (24 * 3600))
    end

    it "should convert minutes as a float fraction of days" do
      Date.unit_value(:minute, 10).should be_within(TOLERANCE).of(10.0 / (24 * 60))
    end

    it "should convert hours as a float fraction of days" do
      Date.unit_value(:hour, 10).should be_within(TOLERANCE).of(10.0 / 24)
    end

    it "should convert days as a float multiple of days" do
      Date.unit_value(:day, 10).should == 10.0
    end

    it "should convert months as an integer multiple of 30 days" do
      Date.unit_value(:month, 10).should == 300.0
    end

    it "should convert years as a float multiple of 365.25 days" do
      Date.unit_value(:year, 10).should == (10.0  * 365.25)
    end
  end

  describe "Time units" do
    before :all do
      @time = Time.now
    end

    it "should raise ArgumentError if an invalid unit is provided" do
      lambda { Time.unit_value(:bogus_unit, 1.0) }.should raise_error(ArgumentError)
    end

    it "should convert seconds as a float multiple of seconds" do
      Time.unit_value(:second, 10).should == 10.0
    end

    it "should convert minutes as a float multiple of seconds" do
      Time.unit_value(:minute, 10).should == (10.0  * 60)
    end

    it "should convert hours as a float multiple of seconds" do
      Time.unit_value(:hour, 10).should == (10.0 * 3600)
    end

    it "should convert days as a float multiple of seconds" do
      Time.unit_value(:day, 10).should == (10.0 * 24 * 3600)
    end

    it "should convert months as a float multiple of 30 days" do
      Time.unit_value(:month, 10).should == (10.0 * 30.0 * 24 * 3600)
    end

    it "should convert years as a float multiple of 365.25 days" do
      Time.unit_value(:year, 10).should == (10.0 * 365.25 * 24 * 3600)
    end
  end
end
