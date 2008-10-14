require "clockwork" unless defined? Clockwork

module Clockwork
  module Holidays
    module UnitedStates
      CHRISTMAS_EVE = Clockwork {|c| c.december & c.mday(24) }
      CHRISTMAS_DAY = Clockwork {|c| c.december & c.mday(25) }
      NEW_YEARS_EVE = Clockwork {|c| c.december & c.mday(31) }
      NEW_YEARS_DAY = Clockwork {|c| c.january & c.mday(1) } # January 1

      MARTIN_LUTHER_KING_JR_DAY = Clockwork {|c| c.january & c.monday(3) } # January 21 (3rd Monday of January, traditionally Jan. 15)

      GROUNDHOG_DAY = Clockwork {|c| c.february & c.mday(2) } # February 2
      SUPER_BOWL_SUNDAY = Clockwork {|c| c.february & c.sunday(1) } # February 3 (currently the first Sunday of February)
      VALENTINES_DAY = Clockwork {|c| c.february & c.mday(14) } # February 14

      PRESIDENTS_DAY = Clockwork {|c| c.february & c.monday(3)} # February 18 (officially Washington's Birthday; 3rd Monday of February, traditionally Feb. 22)
      ST_PATRICKS_DAY = Clockwork {|c| c.march & c.mday(17)  } # March 17

      APRIL_FOOLS_DAY = Clockwork {|c| c.april & c.mday(1)} # April 1

      PATRIOTS_DAYMARATHON_MONDAY = Clockwork { |c| c.april & c.monday(3) } # April 21 (New England and Wisconsin only) (3rd Monday of April)
      EARTH_DAY = Clockwork {|c| c.april & c.mday(22) }
      ARBOR_DAY = Clockwork {|c| c.april & c.mday(25) }

      MOTHERS_DAY = Clockwork {|c| c.may & c.sunday(2) }  #(2nd Sunday of may),
      FATHERS_DAY = Clockwork {|c| c.june & c.sunday(3) }  #(3rd Sunday of june)

      CINCO_DE_MAYO = Clockwork {|c| c.may & c.mday(5) } # (Mexican holiday often observed in US)

      LABOR_DAY = Clockwork {|c| c.september & c.monday(1) }  #(first Monday of September)
      COLUMBUS_DAY = Clockwork {|c| c.october & c.monday(2) } # (2nd Monday of october, traditionally Oct. 12)

      MISCHIEF_NIGHT = Clockwork {|c| c.october & c.mday(30) }
      HALLOWEEN = Clockwork {|c| c.october & c.mday(31) }
      ALL_SAINTS_DAY_DAY_OF_THE_DEAD = Clockwork {|c| c.november & c.mday(1) }  #(Mexico)

      ELECTION_DAY = Clockwork do |c| # (Tuesday after the first Monday of november)
        first_monday_in_nov = c.november & c.monday(1)
        c.proc { |dt| first_monday_in_nov === (dt - 1) }
      end

      FLAG_DAY = Clockwork {|c| c.june & c.mday(14) }
      INDEPENDENCE_DAY = Clockwork {|c| c.july & c.mday(4) }
      MEMORIAL_DAY = Clockwork {|c| c.may & c.monday(-1) } # (last Monday of may, traditionally may 30)
      VETERANS_DAY = Clockwork {|c| c.november & c.mday(11) }

      THANKSGIVING = Clockwork {|c| c.november & c.thursday(4) } # (4th Thursday of november)
      BLACK_FRIDAY = Clockwork do |c| # (Friday after Thanksgiving Day)
        c.proc { |dt| THANKSGIVING === (dt - 1) }
      end

      PEARL_HARBOR_REMEMBRANCE_DAY = Clockwork {|c| c.december & c.mday(7) }
      FIRST_DAY_OF_KWANZAA = Clockwork {|c| c.december & c.mday(26) }

      # (Kwanzaa is celebrated until January 1, 2009)


      #moveable
      VERNAL_EQUINOX   = Clockwork {|c| c.march & c.mday(21) }     # March 21 (based on sun)
      SUMMER_SOLSTICE  = Clockwork {|c| c.june & c.mday(21) }      # June 21 (based on sun)
      AUTUMNAL_EQUINOX = Clockwork {|c| c.september & c.mday(21) } # September 21 (based on sun)
      WINTER_SOLSTICE  = Clockwork {|c| c.december & c.mday(21) }  # December 21 (based on sun)
    end
  end
end
