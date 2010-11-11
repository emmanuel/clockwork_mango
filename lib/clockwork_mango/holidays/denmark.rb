require "clockwork_mango"

module ClockworkMango
  module Holidays
    module Denmark
      extend HolidayCollection

      NEW_YEARS_DAY             = Clockwork { january(1) }
      MAUNDY_THURSDAY           = Clockwork { march(20) }
      GOOD_FRIDAY               = Clockwork { march(21) }
      EASTER_MONDAY             = Clockwork { march(24) }
      GENERAL_PRAYER_DAY        = Clockwork { april(18) }
      LABOUR_DAY                = Clockwork { may(1) }
      ASCENSION_DAY             = Clockwork { may(1) }
      WHIT_MONDAY               = Clockwork { may(12) }
      CONSTITUTION_DAY          = Clockwork { june(5) }
      JUL_DENMARK_CHRISTMAS_EVE = Clockwork { december(24) }
      JUL_DENMARK_CHRISTMAS_DAY = Clockwork { december(25) }
      BOXING_DAY                = Clockwork { december(26) }

    end
  end
end
