require "clockwork" unless defined? Clockwork

module Clockwork

  module Holidays
    module Estonia

      NEW_YEARS_DAY = Clockwork{|c| c.january & c.mday(1)}
      INDEPENDENCE_DAY = Clockwork{|c| c.february & c.mday(24)}
      #GOOD_FRIDAY__VARIABLE_DATE = Clockwork{|c| c.april & c.mday(6)}
      #EASTER_DAY__VARIABLE_DATE = Clockwork{|c| c.april & c.mday(8)}
      SPRING_DAY = Clockwork{|c| c.may & c.mday(1)}
      #WHITSUNDAY__VARIABLE_DATE = Clockwork{|c| c.may & c.mday(27)}
      VICTORY_DAY = Clockwork{|c| c.june & c.mday(23)}
      MIDSUMMER_DAY = Clockwork{|c| c.june & c.mday(24)}
      DAY_OF_RESTORATION_OF_INDEPENDENCE = Clockwork{|c| c.august & c.mday(20)}
      CHRISTMAS_EVE = Clockwork{|c| c.december & c.mday(24)}
      CHRISTMAS_DAY = Clockwork{|c| c.december & c.mday(25)}
      extend HolidayMixin

    end
  end

end
