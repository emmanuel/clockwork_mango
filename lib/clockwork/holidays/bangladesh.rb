require "clockwork" unless defined? Clockwork

module Clockwork
  module Holidays
    module Bangladesh


      INTERNATIONAL_MOTHER_LANGUAGE_DAY = Clockwork{|x| c.february & c.mday(21)}
      INDEPENDENCE_DAY = Clockwork{|x| c.march & c.mday(26)}
      BENGLI_NEW_YEARS_DAY = Clockwork{|x| c.april & c.mday(14)}
      MAY_DAY = Clockwork{|x| c.may & c.mday(1)}
      NATIONAL_SOLIDARITY_DAY = Clockwork{|x| c.november & c.mday(7)}
      VICTORY_DAY = Clockwork{|x| c.december & c.mday(16)}
      #20-22 December-Eid-ul-Azha
      CHRISTMAS_DAY = Clockwork{|x| c.december & c.mday(25)}

    end
  end
end
