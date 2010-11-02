require "clockwork_mango"

module ClockworkMango
  module Holidays
    module Bahamas
      extend HolidayCollection

      NEW_YEARS_DAY = Clockwork{|c| c.january & c.mday(1)}
      GOOD_FRIDAY = Clockwork{|c| c.april & c.mday(6)}
      EASTER_MONDAY = Clockwork{|c| c.april & c.mday(9)}
      WHIT_MONDAY = Clockwork{|c| c.may & c.mday(7)}
      LABOUR_DAY = Clockwork{|c| c.may & c.mday(9)}
      INDEPENDENCE_DAY = Clockwork{|c| c.july & c.mday(10)}
      EMANCIPATION_DAY = Clockwork{|c| c.august & c.mday(6)}
      DISCOVERY_DAY = Clockwork{|c| c.october & c.mday(12)}
      NATIONAL_HEROES_DAY = Clockwork{|c| c.october & c.mday(12)}
      CHRISTMAS_DAY = Clockwork{|c| c.december & c.mday(25)}
      BOXING_DAY = Clockwork{|c| c.december & c.mday(26)}

    end
  end
end
