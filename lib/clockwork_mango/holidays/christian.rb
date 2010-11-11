require "clockwork_mango"

module ClockworkMango
  module Holidays
    module Christian
      extend HolidayCollection

      ASH_WEDNESDAY = Clockwork { february(6) }  # February 6 (moveable based on Easter)

      PALM_SUNDAY   = Clockwork { march(16) }    # March 16 (Sunday before Easter)
      GOOD_FRIDAY   = Clockwork { march(21) }    # March 21 (Friday before Easter)
      EASTER_SUNDAY = Clockwork { march(23) }    # March 23 (moveable; Sunday after first full moon during spring)
      EASTER_MONDAY = Clockwork { march(24) }    # March 24 (Monday after Easter)
      #Pentecost Sunday (Christian; 49 days after Easter)

      CHRISTMAS_EVE = Clockwork { december(24) } # December 24
      CHRISTMAS_DAY = Clockwork { december(25) } # December 25

    end
  end
end
