require "clockwork_mango"

module ClockworkMango
  module Holidays
    module Estonia
      extend HolidayCollection

      NEW_YEARS_DAY                      = Clockwork { january(1) }
      INDEPENDENCE_DAY                   = Clockwork { february(24) }
      #GOOD_FRIDAY__VARIABLE_DATE        = Clockwork { april(6) }
      #EASTER_DAY__VARIABLE_DATE         = Clockwork { april(8) }
      SPRING_DAY                         = Clockwork { may(1) }
      #WHITSUNDAY__VARIABLE_DATE         = Clockwork { may(27) }
      VICTORY_DAY                        = Clockwork { june(23) }
      MIDSUMMER_DAY                      = Clockwork { june(24) }
      DAY_OF_RESTORATION_OF_INDEPENDENCE = Clockwork { august(20) }
      CHRISTMAS_EVE                      = Clockwork { december(24) }
      CHRISTMAS_DAY                      = Clockwork { december(25) }

    end
  end
end
