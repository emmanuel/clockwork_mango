require "clockwork" unless defined? Clockwork

module Clockwork
  module Holidays
    module CostaRica

      NEW_YEARS_DAY = Clockwork{|x| c.january & c.mday(1)}
      BATTLE_OF_RIVAS_DAY = Clockwork{|x| c.april & c.mday(11)}
      #Holy Thursday, and Good Friday - variable dates
      LABOUR_DAY = Clockwork{|x| c.may & c.mday(1)}
      GUANACASTE_DAY = Clockwork{|x| c.july & c.mday(25)}
      VIRGEN_DE_LOS_ANGELES_DAY = Clockwork{|x| c.august & c.mday(2)}
      MOTHERS_DAY = Clockwork{|x| c.august & c.mday(15)}
      INDEPENDENCE_DAY = Clockwork{|x| c.september & c.mday(15)}
      MEETING_OF_CULTURES_DAY = Clockwork{|x| c.october & c.mday(12)}
      CHRISTMAS_DAY = Clockwork{|x| c.december & c.mday(25)}

    end
  end

end
