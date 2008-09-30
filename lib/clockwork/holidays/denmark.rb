require "clockwork" unless defined? Clockwork

module Clockwork

  module Holidays
    module Denmark


      NEW_YEARS_DAY = Clockwork{|x| c.january & c.mday(1)}
      MAUNDY_THURSDAY = Clockwork{|x| c.march & c.mday(20)}
      GOOD_FRIDAY = Clockwork{|x| c.march & c.mday(21)}
      EASTER_MONDAY = Clockwork{|x| c.march & c.mday(24)}
      GENERAL_PRAYER_DAY = Clockwork{|x| c.april & c.mday(18)}
      LABOUR_DAY = Clockwork{|x| c.may & c.mday(1)}
      ASCENSION_DAY = Clockwork{|x| c.may & c.mday(1)}
      WHIT_MONDAY = Clockwork{|x| c.may & c.mday(12)}
      CONSTITUTION_DAY = Clockwork{|x| c.june & c.mday(5)}
      JUL_DENMARK_CHRISTMAS_EVE = Clockwork{|x| c.december & c.mday(24)}
      JUL_DENMARK_CHRISTMAS_DAY = Clockwork{|x| c.december & c.mday(25)}
      BOXING_DAY = Clockwork{|x| c.december & c.mday(26)}

    end
  end

end
