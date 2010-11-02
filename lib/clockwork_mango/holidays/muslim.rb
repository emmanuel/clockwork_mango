require "clockwork_mango"

module ClockworkMango
  module Holidays
    module Muslim
      extend HolidayCollection

      FIRST_DAY_OF_RAMADAN = Clockwork {|c| } # September 2 (Islamic, moveable based on Lunar calendar)
      EID_AL_FITR_DAY_AFTER_THE_END_OF_RAMADAN = Clockwork {|c| } # October 2 (Islamic, moveable, based on lunar calendar)

    end
  end
end
