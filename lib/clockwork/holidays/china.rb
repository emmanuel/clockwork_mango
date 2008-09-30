require "clockwork" unless defined? Clockwork

module Clockwork
  module Holidays
    module China

      #Traditional holidays:

      #CHINESE_LUNAR_NEW_YEAR = Clockwork{|x| c.lunar calendar month 1 day & c.mday(1)}
      #LANTERN_FESTIVAL = Clockwork{|x| c.lunar calendar month 1 day & c.mday(15)}
      QING_MING_JIE = Clockwork{|x| c.april & c.mday(5)}
      #DRAGON_BOAT = Clockwork{|x| c.lunar calendar month 5 day & c.mday(5)}
      #QI_XI = Clockwork{|x| c.lunar calendar month 7 day & c.mday(7)}
      #GHOST_FESTIVAL = Clockwork{|x| c.lunar calendar month 7 day & c.mday(15)}
      #MIDAUTUMN_FESTIVAL = Clockwork{|x| c.lunar calendar month 8 day & c.mday(15)}
      #DOUBLE_NINTH_CHONG_YANG_FESTIVAL = Clockwork{|x| c.lunar calendar month 9 day & c.mday(9)}

      #Holidays in the People's Republic of China:

      NEW_YEARS_DAY = Clockwork{|x| c.january & c.mday(1)}
      NEW_YEARS_DAY_HOLIDAY = Clockwork{|x| c.january & c.mday(2)}
      CHINESE_NEW_YEAR = Clockwork{|x| c.february & c.mday(2)}
      LABOUR_DAY = Clockwork{|x| c.may 1-may & c.mday(3)}
      CPC_FOUNDING_DAY = Clockwork{|x| c.july & c.mday(1)}
      ARMY_DAY = Clockwork{|x| c.august & c.mday(1)}
      NATIONAL_DAY = Clockwork{|x| c.october 1-october & c.mday(3)}


      #Chinese calendar
      #Public holidays in Hong Kong
      #Public holidays in Macau

    end
  end

end
