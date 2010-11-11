require "clockwork_mango"

module ClockworkMango
  module Holidays
    module Bahamas
      extend HolidayCollection

      NEW_YEARS_DAY       = Clockwork { january(1) }
      GOOD_FRIDAY         = Clockwork { april(6) }
      EASTER_MONDAY       = Clockwork { april(9) }
      WHIT_MONDAY         = Clockwork { may(7) }
      LABOUR_DAY          = Clockwork { may(9) }
      INDEPENDENCE_DAY    = Clockwork { july(10) }
      EMANCIPATION_DAY    = Clockwork { august(6) }
      DISCOVERY_DAY       = Clockwork { october(12) }
      NATIONAL_HEROES_DAY = Clockwork { october(12) }
      CHRISTMAS_DAY       = Clockwork { december(25) }
      BOXING_DAY          = Clockwork { december(26) }

    end
  end
end
