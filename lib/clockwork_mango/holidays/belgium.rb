require "clockwork_mango"

module ClockworkMango
  module Holidays
    module Belgium
      extend HolidayCollection

      NEW_YEARS_DAY             = Clockwork { january(1) }
      #Good Friday, Easter Sunday and Easter Monday - variable dates
      LABOUR_DAY                = Clockwork { may(1) }
      #Ascension day - (variable date)
      #Whit Sunday or Pentecost - (variable date)
      #Whit Monday or Pentecost Monday - (variable date)
      FLEMISH_COMMUNITY_HOLIDAY = Clockwork { july(11) } #_ONLY_HELD_IN_FLANDERS__NOT_A_PUBLIC_HOLIDAY
      NATIONAL_HOLIDAY          = Clockwork { july(21) }
      ASSUMPTION_OF_MARY        = Clockwork { august(15) }
      FRENCH_COMMUNITY_HOLIDAY  = Clockwork { september(27) } # _ONLY_HELD_IN_WALLONIA__NOT_A_PUBLIC_HOLIDAY
      ALL_SAINTS                = Clockwork { november(1) }
      ALL_SOULS_DAY             = Clockwork { november(2) } # _NOT_A_PUBLIC_HOLIDAY_MOST_COMPANIES_ARE_CLOSED
      ARMISTICE_DAY             = Clockwork { november(11) }
      DYNASTY_DAY               = Clockwork { november(15) } #__DAY_OF_GERMANSPEAKING_COMMUNITY_ONLY_HELD_IN_AREAS_OF_THE_GERMANSPEAKING_COMMUNITY_OF_BELGIUM
      CHRISTMAS_DAY             = Clockwork { december(25) }

    end
  end
end
