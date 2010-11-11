require "clockwork_mango"

module ClockworkMango
  module Holidays
    module Argentina
      extend HolidayCollection

      NEW_YEARS_DAY               = Clockwork { january(1) }
      LABOUR_DAY                  = Clockwork { may(1) }
      THE_MAY_REVOLUTION          = Clockwork { may(25) }
      FLAG_DAY                    = Clockwork { june(20) }
      DECLARATION_OF_INDEPENDENCE = Clockwork { july(9) }
      TEACHERS_DAY                = Clockwork { september(11) }
      CHRISTMAS_DAY               = Clockwork { december(25) }

    end
  end
end
