require "clockwork_mango"

module ClockworkMango
  module Holidays
    module Barbados
      extend HolidayCollection

      NEW_YEARS_DAY      = Clockwork { january(1) }
      ERROL_BARROW_DAY   = Clockwork { january(21) }
      #Good Friday
      #Easter Monday
      NATIONAL_HEROESDAY = Clockwork { april(28) }
      #1st Monday of May-Labour Day
      #Whit Monday
      #1st Monday in August-Kadooment Day
      EMANCIPATION_DAY   = Clockwork { august(1) }
      INDEPENDENCE_DAY   = Clockwork { november(30) }
      CHRISTMAS_DAY      = Clockwork { december(25) }
      BOXING_DAY         = Clockwork { december(26) }
      # BOXING_DAY         = Clockwork { december(27) }

    end
  end
end
