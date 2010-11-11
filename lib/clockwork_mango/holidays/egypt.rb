require "clockwork_mango"

module ClockworkMango
  module Holidays
    module Egypt
      extend HolidayCollection

      COPTIC_CHRISTMAS_DAY    = Clockwork { january(7) }
      DAY_OF_SINAI_LIBERATION = Clockwork { april(25) } # _OBSERVED_IN_THE_SINAI_ONLY
      LABOUR_DAY              = Clockwork { may(1) }
      EVACUATION_DAY          = Clockwork { june(18) }
      REVOLUTION_DAY          = Clockwork { july(23) }
      FLOODING_OF_THE_NILE    = Clockwork { august(15) }
      ARMED_FORCES_DAY        = Clockwork { october(6) }
      SUEZ_VICTORY_DAY        = Clockwork { october(24) }
      VICTORY_DAY             = Clockwork { december(23) }
      #Eid ul-Adha - variable date (celebrated by muslims)
      #Eid ul-Fitr - variable date (celebrated by muslims)
      #Easter Sunday and Easter Monday - variable date
      #Islamic New Year - variable date

      #In addition, the following holidays are reserved for observance by Copts, though are not national holidays:

      COPTIC_NEW_YEARS_DAY    = Clockwork { september(11) }

    end
  end
end
