require "clockwork_mango"

module ClockworkMango
  module Holidays
    module Cyprus
      extend HolidayCollection

      NEW_YEARS_DAY           = Clockwork { january(1) }
      #Good Friday, Easter Sunday and Easter Monday - variable dates
      GREEK_INDEPENDENCE_DAY  = Clockwork { march(25) }
      CYPRUS_NATIONAL_DAY     = Clockwork { april(1) }
      LABOUR_DAY              = Clockwork { may(1) }
      ASSUMPTION_OF_MARY      = Clockwork { august(15) }
      CYPRUS_INDEPENDENCE_DAY = Clockwork { october(1) }
      CHRISTMAS_DAY           = Clockwork { december(25) }
      BOXING_DAY              = Clockwork { december(26) }

    end
  end
end
