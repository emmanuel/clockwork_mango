require "clockwork" unless defined? Clockwork

module Clockwork
  module Holidays
    module Jewish
      FIRST_DAY_OF_PASSOVER  = Clockwork { |c| c.april & c.mday(20) }     # April 20 (moveable based on Jewish calendar)
      LAST_DAY_OF_PASSOVER   = Clockwork { |c| c.april & c.mday(27) }     # April 27 (moveable based on Jewish Calendar)
      OCT_1_ROSH_HASHANAH    = Clockwork { |c| c.september & c.mday(30) } # September 30 (moveable based on Jewish calendar)
      YOM_KIPPUR             = Clockwork { |c| c.october & c.mday(9) }   # October 9 (Jewish, moveable 9 days after first day of Rosh Hashanah), Leif Erikson Day
      FIRST_DAY_OF_SUKKOT    = Clockwork { |c| c.october & c.mday(14) }  # October 14 (moveable 14 days after Rosh Hashanaah)
      LAST_DAY_OF_SUKKOT     = Clockwork { |c| c.october & c.mday(20) }   # October 20 (moveable based on Jewish calendar)
      SIMCHAT_TORAH          = Clockwork { |c| c.october & c.mday(22) }  # October 22 (moveable 22 days after Rosh Hashanah)
      FIRST_DAY_OF_HANNUKKAH = Clockwork { |c| c.december & c.mday(22) }  # December 22 (moveable based on Jewish calendar)
      LAST_DAY_OF_HANNUKKAH  = Clockwork { |c| c.december & c.mday(29) }  # December 29 (moveable based on Jewish Calendar)
    end
  end
end
