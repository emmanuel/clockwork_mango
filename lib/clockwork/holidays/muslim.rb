require "clockwork" unless defined? Clockwork

module Clockwork
  module Holidays
    module Muslim

      FIRST_DAY_OF_RAMADAN = Clockwork {|c| } # September 2 (Islamic, moveable based on Lunar calendar)
      EID_AL_FITR_DAY_AFTER_THE_END_OF_RAMADAN = Clockwork {|c| } # October 2 (Islamic, moveable, based on lunar calendar)

      extend HolidayMixin
    end
  end
end
