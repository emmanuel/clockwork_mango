require "clockwork_mango"

module ClockworkMango
  module Holidays
    module Jewish
      extend HolidayCollection

      FIRST_DAY_OF_PASSOVER  = Clockwork { april(20) }     # April 20 (moveable based on Jewish calendar)
      LAST_DAY_OF_PASSOVER   = Clockwork { april(27) }     # April 27 (moveable based on Jewish Calendar)
      OCT_1_ROSH_HASHANAH    = Clockwork { september(30) } # September 30 (moveable based on Jewish calendar)
      YOM_KIPPUR             = Clockwork { october(9) }   # October 9 (Jewish, moveable 9 days after first day of Rosh Hashanah), Leif Erikson Day
      FIRST_DAY_OF_SUKKOT    = Clockwork { october(14) }  # October 14 (moveable 14 days after Rosh Hashanaah)
      LAST_DAY_OF_SUKKOT     = Clockwork { october(20) }   # October 20 (moveable based on Jewish calendar)
      SIMCHAT_TORAH          = Clockwork { october(22) }  # October 22 (moveable 22 days after Rosh Hashanah)
      FIRST_DAY_OF_HANNUKKAH = Clockwork { december(22) }  # December 22 (moveable based on Jewish calendar)
      LAST_DAY_OF_HANNUKKAH  = Clockwork { december(29) }  # December 29 (moveable based on Jewish Calendar)

    end
  end
end
