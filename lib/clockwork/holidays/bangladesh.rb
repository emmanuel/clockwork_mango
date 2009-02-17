require "clockwork" unless defined? Clockwork

module Clockwork
  module Holidays
    module Bangladesh


      INTERNATIONAL_MOTHER_LANGUAGE_DAY = Clockwork{|c| c.february & c.mday(21)}
      INDEPENDENCE_DAY = Clockwork{|c| c.march & c.mday(26)}
      BENGLI_NEW_YEARS_DAY = Clockwork{|c| c.april & c.mday(14)}
      MAY_DAY = Clockwork{|c| c.may & c.mday(1)}
      NATIONAL_SOLIDARITY_DAY = Clockwork{|c| c.november & c.mday(7)}
      VICTORY_DAY = Clockwork{|c| c.december & c.mday(16)}
      #20-22 December-Eid-ul-Azha
      CHRISTMAS_DAY = Clockwork{|c| c.december & c.mday(25)}
      extend HolidayMixin

    end
  end
end
