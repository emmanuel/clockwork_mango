require "clockwork_mango"

module ClockworkMango
  module Holidays
    module Chile
      extend HolidayCollection

      NEW_YEARS_DAY = Clockwork{|c| c.january & c.mday(1)}
      #March/April - Good Friday
      #March/April - Easter
      LABOUR_DAY = Clockwork{|c| c.may & c.mday(1)}
      NAVY_DAY = Clockwork{|c| c.may & c.mday(21)}
      #June - Corpus Christi
      #June 27 - Feast of Saints Peter and Paul
      ASSUMPTION_OF_MARY = Clockwork{|c| c.august & c.mday(15)}
      INDEPENDENCE_DAY = Clockwork{|c| c.september & c.mday(18)}
      GLORIES_OF_THE_ARMY_DAY = Clockwork{|c| c.september & c.mday(19)}
      #October 12 - Columbus Day
      ALL_SAINTS = Clockwork{|c| c.november & c.mday(1)}
      IMMACULATE_CONCEPTION = Clockwork{|c| c.december & c.mday(8)}
      CHRISTMAS_DAY = Clockwork{|c| c.december & c.mday(25)}

    end
  end
end
