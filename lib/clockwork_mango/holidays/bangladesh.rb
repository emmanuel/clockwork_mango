require "clockwork_mango"

module ClockworkMango
  module Holidays
    module Bangladesh
      extend HolidayCollection


      INTERNATIONAL_MOTHER_LANGUAGE_DAY = Clockwork { february(21) }
      INDEPENDENCE_DAY                  = Clockwork { march(26) }
      BENGLI_NEW_YEARS_DAY              = Clockwork { april(14) }
      MAY_DAY                           = Clockwork { may(1) }
      NATIONAL_SOLIDARITY_DAY           = Clockwork { november(7) }
      VICTORY_DAY                       = Clockwork { december(16) }
      #20-22 December-Eid-ul-Azha
      CHRISTMAS_DAY                     = Clockwork { december(25) }

    end
  end
end
