require "clockwork_mango"

module ClockworkMango
  module Holidays
    module FederationOfBosniaAndHerzegovina
      extend HolidayCollection

      NEW_YEARS_DAY = Clockwork{|c| c.january & c.mday(1)}
      #Easter
      MAY_DAY = Clockwork{|c| c.may & c.mday(1)}
      #Christmas

    end
  end
end
