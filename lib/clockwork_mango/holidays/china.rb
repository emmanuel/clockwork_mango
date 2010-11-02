require "clockwork_mango"

module ClockworkMango
  module Holidays
    module China
      extend HolidayCollection

      #Traditional holidays:

      #CHINESE_LUNAR_NEW_YEAR = Clockwork{|c| c.lunar calendar month 1 day & c.mday(1)}
      #LANTERN_FESTIVAL = Clockwork{|c| c.lunar calendar month 1 day & c.mday(15)}
      QING_MING_JIE = Clockwork{|c| c.april & c.mday(5)}
      #DRAGON_BOAT = Clockwork{|c| c.lunar calendar month 5 day & c.mday(5)}
      #QI_XI = Clockwork{|c| c.lunar calendar month 7 day & c.mday(7)}
      #GHOST_FESTIVAL = Clockwork{|c| c.lunar calendar month 7 day & c.mday(15)}
      #MIDAUTUMN_FESTIVAL = Clockwork{|c| c.lunar calendar month 8 day & c.mday(15)}
      #DOUBLE_NINTH_CHONG_YANG_FESTIVAL = Clockwork{|c| c.lunar calendar month 9 day & c.mday(9)}

      #Holidays in the People's Republic of China:

      NEW_YEARS_DAY = Clockwork{|c| c.january & c.mday(1)}
      NEW_YEARS_DAY_HOLIDAY = Clockwork{|c| c.january & c.mday(2)}
      CHINESE_NEW_YEAR = Clockwork{|c| c.february & c.mday(2)}
      LABOUR_DAY = Clockwork{|c| c.may & c.mday(3)}
      CPC_FOUNDING_DAY = Clockwork{|c| c.july & c.mday(1)}
      ARMY_DAY = Clockwork{|c| c.august & c.mday(1)}
      NATIONAL_DAY = Clockwork{|c| c.october & c.mday(3)}


      #Chinese calendar
      #Public holidays in Hong Kong
      #Public holidays in Macau

    end
  end
end
