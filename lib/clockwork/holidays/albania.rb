require "clockwork" unless defined? Clockwork

module Clockwork
  module Holidays
    module Albania

      NEW_YEARS_DAY = Clockwork{|c| c.january & c.mday(1)}
      MOTHERS_DAY_AND_TEACHERS_DAY = Clockwork{|c| c.march & c.mday(7)}
      SULTAN_NOURUZ_REMEMBRANCE = Clockwork{|c| c.march & c.mday(22)}
      LABOUR_DAY = Clockwork{|c| c.may & c.mday(1)}
      MOTHER_TERESA_DAY = Clockwork{|c| c.october & c.mday(19)}
      INDEPENDENCE_DAY = Clockwork{|c| c.november & c.mday(28)}
      CHRISTMAS_DAY = Clockwork{|c| c.december & c.mday(25)}
      INNOCENTS_DAY = Clockwork{|c| c.december & c.mday(28)}

    end
  end

end
