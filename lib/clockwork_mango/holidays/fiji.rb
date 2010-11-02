require "clockwork_mango"

module ClockworkMango
  module Holidays
    module Fiji
      extend HolidayCollection

      NEW_YEARS_DAY = Clockwork{|c| c.january & c.mday(1)}
      PROPHET_MUHAMMADS_BIRTHDAY = Clockwork{|c| c.april & c.mday(2)}
      GOOD_FRIDAY = Clockwork{|c| c.april & c.mday(6)}
      EASTER_SATURDAY = Clockwork{|c| c.april & c.mday(7)}
      EASTER_MONDAY = Clockwork{|c| c.april & c.mday(9)}
      NATIONAL_YOUTH_DAY = Clockwork{|c| c.may & c.mday(4)}
      RATU_SIR_LALA_SUKUNA_DAY = Clockwork{|c| c.may & c.mday(28)}
      QUEENS_BIRTHDAY = Clockwork{|c| c.june & c.mday(18)}
      FIJI_DAY = Clockwork{|c| c.october & c.mday(8)}
      DIWALI = Clockwork{|c| c.november & c.mday(9)}
      CHRISTMAS_DAY = Clockwork{|c| c.december & c.mday(25)}
      BOXING_DAY = Clockwork{|c| c.december & c.mday(26)}

    end
  end
end
