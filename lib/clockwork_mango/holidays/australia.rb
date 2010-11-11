require "clockwork_mango"

module ClockworkMango
  module Holidays
    module Australia
      extend HolidayCollection

      NEW_YEARS_DAY = Clockwork { january(1) }
      AUSTRALIA_DAY = Clockwork { january(26) }
      #Good Friday, Holy Saturday and Easter Monday - variable dates
      #Second Monday in March - Adelaide Cup Day (South Australia only) Before 2006 held in May
      ANZAC_DAY     = Clockwork { april(25) }
      #Second Monday in June - Queen's Birthday (except Western Australia)
      #First Tuesday in November - Melbourne Cup Day (Metropolitan Melbourne and ACT[1] only, although observed by many businesses across the country); other regions may have a public holiday on the day of a horse race of local significance.
      CHRISTMAS_DAY = Clockwork { december(25) }
      BOXING_DAY_EXCEPT_SOUTH_AUSTRALIA     = Clockwork { december(26) }
      PROCLAMATION_DAY_SOUTH_AUSTRALIA_ONLY = Clockwork { december(26) }
      #Labour Day (localised holiday, on a different day in each region)
      #Show Day (localised holiday, on a different day in each region)

    end
  end
end
