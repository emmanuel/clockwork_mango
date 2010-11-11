require "clockwork_mango"

module ClockworkMango
  module Holidays
    module FederationOfBosniaAndHerzegovina
      extend HolidayCollection

      NEW_YEARS_DAY = Clockwork { january(1) }
      #Easter
      MAY_DAY       = Clockwork { may(1) }
      #Christmas

    end
  end
end
