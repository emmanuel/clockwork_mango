require "clockwork_mango"

module ClockworkMango
  module Holidays
    module Fiji
      extend HolidayCollection

      NEW_YEARS_DAY              = Clockwork { january(1) }
      PROPHET_MUHAMMADS_BIRTHDAY = Clockwork { april(2) }
      GOOD_FRIDAY                = Clockwork { april(6) }
      EASTER_SATURDAY            = Clockwork { april(7) }
      EASTER_MONDAY              = Clockwork { april(9) }
      NATIONAL_YOUTH_DAY         = Clockwork { may(4) }
      RATU_SIR_LALA_SUKUNA_DAY   = Clockwork { may(28) }
      QUEENS_BIRTHDAY            = Clockwork { june(18) }
      FIJI_DAY                   = Clockwork { october(8) }
      DIWALI                     = Clockwork { november(9) }
      CHRISTMAS_DAY              = Clockwork { december(25) }
      BOXING_DAY                 = Clockwork { december(26) }

    end
  end
end
