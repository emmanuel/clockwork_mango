require "clockwork_mango"

module ClockworkMango
  module Holidays
    module BritishVirginIslands
      extend HolidayCollection

      NEW_YEARS_DAY           = Clockwork { january(1) }
      LAVITY_STOUTTS_BIRTHDAY = Clockwork { march(5) }
      COMMONWEALTH_DAY        = Clockwork { march(12) }
      #Good Friday - Friday before Easter (calculated according to Western Christian calendar)
      #Easter Monday
      #Whit Monday
      TERRITORY_DAY           = Clockwork { july(1) }
      #1st Monday in August - Festival Monday
      #Tuesday after 1st Monday in August - Festival Tuesday
      #Wednesday after 1st Monday in August - Festival Wednesday
      SAINT_URSULAS_DAY       = Clockwork { october(21) }
      CHRISTMAS_DAY           = Clockwork { december(25) }
      BOXING_DAY              = Clockwork { december(26) }

    end
  end
end
