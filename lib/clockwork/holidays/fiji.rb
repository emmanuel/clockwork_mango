require "clockwork" unless defined? Clockwork

module Clockwork
  module Holidays
    module Fiji


      NEW_YEARS_DAY = Clockwork{|x| c.january & c.mday(1)}

      PROPHET_MUHAMMADS_BIRTHDAY = Clockwork{|x| c.april & c.mday(2)}

      GOOD_FRIDAY = Clockwork{|x| c.april & c.mday(6)}

      EASTER_SATURDAY = Clockwork{|x| c.april & c.mday(7)}

      EASTER_MONDAY = Clockwork{|x| c.april & c.mday(9)}

      NATIONAL_YOUTH_DAY = Clockwork{|x| c.may & c.mday(4)}

      RATU_SIR_LALA_SUKUNA_DAY = Clockwork{|x| c.may & c.mday(28)}

      QUEENS_BIRTHDAY = Clockwork{|x| c.june & c.mday(18)}

      FIJI_DAY = Clockwork{|x| c.october & c.mday(8)}

      DIWALI = Clockwork{|x| c.november & c.mday(9)}

      CHRISTMAS_DAY = Clockwork{|x| c.december & c.mday(25)}

      BOXING_DAY = Clockwork{|x| c.december & c.mday(26)}
    end
  end

end
