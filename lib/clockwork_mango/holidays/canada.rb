require "clockwork_mango"

module ClockworkMango
  module Holidays
    module Canada
      extend HolidayCollection

      NEW_YEARS_DAY   = Clockwork { january(1) }
      #Good Friday
      #Easter Monday - Schools, Banks, and Government
      #VICTORIA_DAY   = Clockwork { first monday on or before may(24) }
      CANADA_DAY      = Clockwork { july(1) }
      #First Monday in September - Labour Day
      #Second Monday in October - Thanksgiving Day
      REMEMBRANCE_DAY = Clockwork { november(11) } #__LIMITED_TO_GOVERNMENT_AGENCIES
      CHRISTMAS_DAY   = Clockwork { december(25) }
      BOXING_DAY      = Clockwork { december(26) }

    end
  end
end
