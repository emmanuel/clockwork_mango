require "clockwork_mango"

module ClockworkMango
  module Holidays
    module China
      extend HolidayCollection

      #Traditional holidays:

      #CHINESE_LUNAR_NEW_YEAR = Clockwork { lunar calendar month 1 day(1) }
      #LANTERN_FESTIVAL       = Clockwork { lunar calendar month 1 day(15) }
      QING_MING_JIE          = Clockwork { april(5) }
      #DRAGON_BOAT            = Clockwork { lunar calendar month 5 day(5) }
      #QI_XI                  = Clockwork { lunar calendar month 7 day(7) }
      #GHOST_FESTIVAL         = Clockwork { lunar calendar month 7 day(15) }
      #MIDAUTUMN_FESTIVAL     = Clockwork { lunar calendar month 8 day(15) }
      #DOUBLE_NINTH_CHONG_YANG_FESTIVAL = Clockwork { lunar calendar month 9 day(9) }

      #Holidays in the People's Republic of China:

      NEW_YEARS_DAY         = Clockwork { january(1) }
      NEW_YEARS_DAY_HOLIDAY = Clockwork { january(2) }
      CHINESE_NEW_YEAR      = Clockwork { february(2) }
      LABOUR_DAY            = Clockwork { may(3) }
      CPC_FOUNDING_DAY      = Clockwork { july(1) }
      ARMY_DAY              = Clockwork { august(1) }
      NATIONAL_DAY          = Clockwork { october(3) }


      #Chinese calendar
      #Public holidays in Hong Kong
      #Public holidays in Macau

    end
  end
end
