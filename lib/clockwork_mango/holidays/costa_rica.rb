require "clockwork_mango"

module ClockworkMango
  module Holidays
    module CostaRica
      extend HolidayCollection

      NEW_YEARS_DAY             = Clockwork { january(1) }
      BATTLE_OF_RIVAS_DAY       = Clockwork { april(11) }
      #Holy Thursday, and Good Friday - variable dates
      LABOUR_DAY                = Clockwork { may(1) }
      GUANACASTE_DAY            = Clockwork { july(25) }
      VIRGEN_DE_LOS_ANGELES_DAY = Clockwork { august(2) }
      MOTHERS_DAY               = Clockwork { august(15) }
      INDEPENDENCE_DAY          = Clockwork { september(15) }
      MEETING_OF_CULTURES_DAY   = Clockwork { october(12) }
      CHRISTMAS_DAY             = Clockwork { december(25) }

    end
  end
end
