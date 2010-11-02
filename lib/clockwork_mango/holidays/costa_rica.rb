require "clockwork_mango"

module ClockworkMango
  module Holidays
    module CostaRica
      extend HolidayCollection

      NEW_YEARS_DAY = Clockwork{|c| c.january & c.mday(1)}
      BATTLE_OF_RIVAS_DAY = Clockwork{|c| c.april & c.mday(11)}
      #Holy Thursday, and Good Friday - variable dates
      LABOUR_DAY = Clockwork{|c| c.may & c.mday(1)}
      GUANACASTE_DAY = Clockwork{|c| c.july & c.mday(25)}
      VIRGEN_DE_LOS_ANGELES_DAY = Clockwork{|c| c.august & c.mday(2)}
      MOTHERS_DAY = Clockwork{|c| c.august & c.mday(15)}
      INDEPENDENCE_DAY = Clockwork{|c| c.september & c.mday(15)}
      MEETING_OF_CULTURES_DAY = Clockwork{|c| c.october & c.mday(12)}
      CHRISTMAS_DAY = Clockwork{|c| c.december & c.mday(25)}

    end
  end
end
