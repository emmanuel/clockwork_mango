require "clockwork" unless defined? Clockwork

module Clockwork
  module Holidays
    module Christian
      ASH_WEDNESDAY = Clockwork { |c| c.february & c.mday(6) }  # February 6 (moveable based on Easter)

      PALM_SUNDAY   = Clockwork { |c| c.march & c.mday(16) }    # March 16 (Sunday before Easter)
      GOOD_FRIDAY   = Clockwork { |c| c.march & c.mday(21) }    # March 21 (Friday before Easter)
      EASTER_SUNDAY = Clockwork { |c| c.march & c.mday(23) }    # March 23 (moveable; Sunday after first full moon during spring)
      EASTER_MONDAY = Clockwork { |c| c.march & c.mday(24) }    # March 24 (Monday after Easter)
      #Pentecost Sunday (Christian; 49 days after Easter)

      CHRISTMAS_EVE = Clockwork { |c| c.december & c.mday(24) } # December 24
      CHRISTMAS_DAY = Clockwork { |c| c.december & c.mday(25) } # December 25
      extend HolidayMixin

    end
  end
end
