require "clockwork" unless defined? Clockwork

module Clockwork
  module Holidays
    module Bahamas

      NEW_YEARS_DAY = Clockwork{|x| c.january & c.mday(1)}
      GOOD_FRIDAY = Clockwork{|x| c.april & c.mday(6)}
      EASTER_MONDAY = Clockwork{|x| c.april & c.mday(9)}
      WHIT_MONDAY = Clockwork{|x| c.may & c.mday(7)}
      LABOUR_DAY = Clockwork{|x| c.may & c.mday(9)}
      INDEPENDENCE_DAY = Clockwork{|x| c.july & c.mday(10)}
      EMANCIPATION_DAY = Clockwork{|x| c.august & c.mday(6)}
      DISCOVERY_DAY = Clockwork{|x| c.october & c.mday(12)}
      NATIONAL_HEROES_DAY = Clockwork{|x| c.october & c.mday(12)}
      CHRISTMAS_DAY = Clockwork{|x| c.december & c.mday(25)}
      BOXING_DAY = Clockwork{|x| c.december & c.mday(26)}

    end
  end
end
