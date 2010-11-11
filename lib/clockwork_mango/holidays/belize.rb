require "clockwork_mango"

module ClockworkMango
  module Holidays
    module Belize
      extend HolidayCollection

      NEW_YEARS_DAY           = Clockwork { january(1) }
      BARON_BLISS_DAY         = Clockwork { march(9) }
      #Good Friday, Holy Saturday, Easter Sunday and Easter Monday - variable dates
      LABOUR_DAY              = Clockwork { may(1) }
      SOVEREIGNS_DAY          = Clockwork { may(24) }
      COMMONWEALTH_DAY        = Clockwork { may(24) }
      ST_GEORGES_CAYE_DAY     = Clockwork { september(10) }
      INDEPENDENCE_DAY        = Clockwork { september(21) }
      PAN_AMERICAN_DAY        = Clockwork { october(12) }
      COLUMBUS_DAY            = Clockwork { october(12) }
      GARIFUNA_SETTLEMENT_DAY = Clockwork { november(19) }
      CHRISTMAS_DAY           = Clockwork { december(25) }
      BOXING_DAY              = Clockwork { december(26) }

    end
  end
end
