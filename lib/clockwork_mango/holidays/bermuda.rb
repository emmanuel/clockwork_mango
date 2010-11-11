require "clockwork_mango"

module ClockworkMango
  module Holidays
    module Bermuda
      extend HolidayCollection

      NEW_YEARS_DAY   = Clockwork { january(1) }
      #variable dates (April 6, 2007) - Good Friday
      BERMUDA_DAY     = Clockwork { may(24) }
      QUEENS_BIRTHDAY = Clockwork { june(11) }
      TRIANGLE_DAY    = Clockwork { july(19) }
      #Thursday before the first Monday in August (August 2, 2007) - Emancipation Day (first Day of Cup Match)
      #Friday before the first Monday in August (August 3, 2007) - Somer's Day (Second day of Cup Match)
      #First Monday in September (September 3, 2007) - Labour Day
      REMEMBRANCE_DAY = Clockwork { november(11) }
      CHRISTMAS_DAY   = Clockwork { december(25) }
      BOXING_DAY      = Clockwork { december(26) }

    end
  end
end
