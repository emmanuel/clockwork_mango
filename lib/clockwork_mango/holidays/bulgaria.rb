require "clockwork_mango"

module ClockworkMango
  module Holidays
    module Bulgaria
      extend HolidayCollection

      NEW_YEARS_DAY              = Clockwork { january(1) }
      LIBERATION_OF_BULGARIA     = Clockwork { march(3) }
      #Easter Monday - moveable
      LABOUR_DAY                 = Clockwork { may(1) }
      ST_GEORGES_DAY             = Clockwork { may(6) }
      ARMY_DAY                   = Clockwork { may(6) }
      EDUCATION_AND_CULTURE_DAY  = Clockwork { may(24) }
      DAY_OF_THE_SLAVIC_HERITAGE = Clockwork { may(24) }
      DAY_OF_THE_UNION_OF_EASTERN_RUMELIA_WITH_THE_BULGARIAN_PRINCIPALITY = Clockwork { september(6) }
      INDEPENDENCE_DAY        = Clockwork { september(22) }
      CHRISTMAS_EVE           = Clockwork { december(24) }
      CHRISTMAS_DAY           = Clockwork { december(25) }
      SECOND_DAY_OF_CHRISTMAS = Clockwork { december(26) }

    end
  end
end
