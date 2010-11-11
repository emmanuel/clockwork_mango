require "clockwork_mango"

module ClockworkMango
  module Holidays
    module Albania
      extend HolidayCollection

      NEW_YEARS_DAY                = Clockwork { january(1) }
      MOTHERS_DAY_AND_TEACHERS_DAY = Clockwork { march(7) }
      SULTAN_NOURUZ_REMEMBRANCE    = Clockwork { march(22) }
      LABOUR_DAY                   = Clockwork { may(1) }
      MOTHER_TERESA_DAY            = Clockwork { october(19) }
      INDEPENDENCE_DAY             = Clockwork { november(28) }
      CHRISTMAS_DAY                = Clockwork { december(25) }
      INNOCENTS_DAY                = Clockwork { december(28) }
    end
  end
end
