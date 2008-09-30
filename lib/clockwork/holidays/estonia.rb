require "clockwork" unless defined? Clockwork

module Clockwork

  module Holidays
    module Estonia

      NEW_YEARS_DAY = Clockwork{|x| c.january & c.mday(1)}
      INDEPENDENCE_DAY = Clockwork{|x| c.february & c.mday(24)}
      #GOOD_FRIDAY__VARIABLE_DATE = Clockwork{|x| c.april & c.mday(6)}
      #EASTER_DAY__VARIABLE_DATE = Clockwork{|x| c.april & c.mday(8)}
      SPRING_DAY = Clockwork{|x| c.may & c.mday(1)}
      #WHITSUNDAY__VARIABLE_DATE = Clockwork{|x| c.may & c.mday(27)}
      VICTORY_DAY = Clockwork{|x| c.june & c.mday(23)}
      MIDSUMMER_DAY = Clockwork{|x| c.june & c.mday(24)}
      DAY_OF_RESTORATION_OF_INDEPENDENCE = Clockwork{|x| c.august & c.mday(20)}
      CHRISTMAS_EVE = Clockwork{|x| c.december & c.mday(24)}
      CHRISTMAS_DAY = Clockwork{|x| c.december & c.mday(25)}

    end
  end

end
