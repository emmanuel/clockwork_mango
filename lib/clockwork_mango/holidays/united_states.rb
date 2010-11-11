require "clockwork_mango"

module ClockworkMango
  module Holidays
    module UnitedStates
      extend HolidayCollection

      CHRISTMAS_EVE = Clockwork { december(24) }
      CHRISTMAS_DAY = Clockwork { december(25) }
      NEW_YEARS_EVE = Clockwork { december(31) }
      NEW_YEARS_DAY = Clockwork { january(1) } # January 1

      MARTIN_LUTHER_KING_JR_DAY = Clockwork { january & monday(3) } # January 21 (3rd Monday of January, traditionally Jan. 15)

      GROUNDHOG_DAY = Clockwork { february(2) } # February 2
      SUPER_BOWL_SUNDAY = Clockwork { february & sunday(1) } # February 3 (currently the first Sunday of February)
      VALENTINES_DAY = Clockwork { february(14) } # February 14

      PRESIDENTS_DAY = Clockwork { february & monday(3) } # February 18 (officially Washington's Birthday; 3rd Monday of February, traditionally Feb. 22)
      ST_PATRICKS_DAY = Clockwork { march(17) } # March 17

      APRIL_FOOLS_DAY = Clockwork { april(1) } # April 1

      PATRIOTS_DAYMARATHON_MONDAY = Clockwork {  april & monday(3) } # April 21 (New England and Wisconsin only) (3rd Monday of April)
      EARTH_DAY = Clockwork { april(22) }
      ARBOR_DAY = Clockwork { april(25) }

      MOTHERS_DAY = Clockwork { may & sunday(2) }  #(2nd Sunday of may),
      FATHERS_DAY = Clockwork { june & sunday(3) }  #(3rd Sunday of june)

      CINCO_DE_MAYO = Clockwork { may(5) } # (Mexican holiday often observed in US)

      LABOR_DAY = Clockwork { september & monday(1) }  #(first Monday of September)
      COLUMBUS_DAY = Clockwork { october & monday(2) } # (2nd Monday of october, traditionally Oct. 12)

      MISCHIEF_NIGHT = Clockwork { october(30) }
      HALLOWEEN = Clockwork { october(31) }
      ALL_SAINTS_DAY = Clockwork { november(1) }
      DAY_OF_THE_DEAD = Clockwork { november(1) }  #(Mexico)

      ELECTION_DAY = Clockwork do |c| # (Tuesday after the first Monday of november)
        first_monday_in_nov = november & monday(1)
        proc { |dt| first_monday_in_nov === (dt - 1) }
      end

      FLAG_DAY = Clockwork { june(14) }
      INDEPENDENCE_DAY = Clockwork { july(4) }
      MEMORIAL_DAY = Clockwork { may & monday(-1) } # (last Monday of may, traditionally may 30)
      VETERANS_DAY = Clockwork { november(11) }

      THANKSGIVING = Clockwork { november & thursday(4) } # (4th Thursday of november)
      BLACK_FRIDAY = Clockwork do |c| # (Friday after Thanksgiving Day)
        proc { |dt| THANKSGIVING === (dt - 1) }
      end

      PEARL_HARBOR_REMEMBRANCE_DAY = Clockwork { december(7) }
      FIRST_DAY_OF_KWANZAA = Clockwork { december(26) }

      # (Kwanzaa is celebrated until January 1, 2009)

      #moveable
      VERNAL_EQUINOX   = Clockwork { march(21) }     # March 21 (based on sun)
      SUMMER_SOLSTICE  = Clockwork { june(21) }      # June 21 (based on sun)
      AUTUMNAL_EQUINOX = Clockwork { september(21) } # September 21 (based on sun)
      WINTER_SOLSTICE  = Clockwork { december(21) }  # December 21 (based on sun)

    end
  end
end
