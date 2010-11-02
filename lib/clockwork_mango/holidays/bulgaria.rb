require "clockwork_mango"

module ClockworkMango
  module Holidays
    module Bulgaria
      extend HolidayCollection

      NEW_YEARS_DAY = Clockwork{|c| c.january & c.mday(1)}
      LIBERATION_OF_BULGARIA = Clockwork{|c| c.march & c.mday(3)}
      #Easter Monday - moveable
      LABOUR_DAY = Clockwork{|c| c.may & c.mday(1)}
      ST_GEORGES_DAY = Clockwork{|c| c.may & c.mday(6)}
      ARMY_DAY = Clockwork{|c| c.may & c.mday(6)}
      EDUCATION_AND_CULTURE_DAY = Clockwork{|c| c.may & c.mday(24)}
      DAY_OF_THE_SLAVIC_HERITAGE = Clockwork{|c| c.may & c.mday(24)}
      DAY_OF_THE_UNION_OF_EASTERN_RUMELIA_WITH_THE_BULGARIAN_PRINCIPALITY = Clockwork{|c| c.september & c.mday(6)}
      INDEPENDENCE_DAY = Clockwork{|c| c.september & c.mday(22)}
      CHRISTMAS_EVE = Clockwork{|c| c.december & c.mday(24)}
      CHRISTMAS_DAY = Clockwork{|c| c.december & c.mday(25)}
      SECOND_DAY_OF_CHRISTMAS = Clockwork{|c| c.december & c.mday(26)}

    end
  end
end
