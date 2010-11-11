require "clockwork_mango"

module ClockworkMango
  module Holidays
    module Chile
      extend HolidayCollection

      NEW_YEARS_DAY           = Clockwork { january(1) }
      #March/April - Good Friday
      #March/April - Easter
      LABOUR_DAY              = Clockwork { may(1) }
      NAVY_DAY                = Clockwork { may(21) }
      #June - Corpus Christi
      #June 27 - Feast of Saints Peter and Paul
      ASSUMPTION_OF_MARY      = Clockwork { august(15) }
      INDEPENDENCE_DAY        = Clockwork { september(18) }
      GLORIES_OF_THE_ARMY_DAY = Clockwork { september(19) }
      #October 12 - Columbus Day
      ALL_SAINTS              = Clockwork { november(1) }
      IMMACULATE_CONCEPTION   = Clockwork { december(8) }
      CHRISTMAS_DAY           = Clockwork { december(25) }

    end
  end
end
