require "clockwork_mango"

module ClockworkMango
  module Holidays
    module Denmark
      extend HolidayCollection

      NEW_YEARS_DAY = Clockwork{|c| c.january & c.mday(1)}
      MAUNDY_THURSDAY = Clockwork{|c| c.march & c.mday(20)}
      GOOD_FRIDAY = Clockwork{|c| c.march & c.mday(21)}
      EASTER_MONDAY = Clockwork{|c| c.march & c.mday(24)}
      GENERAL_PRAYER_DAY = Clockwork{|c| c.april & c.mday(18)}
      LABOUR_DAY = Clockwork{|c| c.may & c.mday(1)}
      ASCENSION_DAY = Clockwork{|c| c.may & c.mday(1)}
      WHIT_MONDAY = Clockwork{|c| c.may & c.mday(12)}
      CONSTITUTION_DAY = Clockwork{|c| c.june & c.mday(5)}
      JUL_DENMARK_CHRISTMAS_EVE = Clockwork{|c| c.december & c.mday(24)}
      JUL_DENMARK_CHRISTMAS_DAY = Clockwork{|c| c.december & c.mday(25)}
      BOXING_DAY = Clockwork{|c| c.december & c.mday(26)}

    end
  end
end
