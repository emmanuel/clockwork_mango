require "clockwork" unless defined? Clockwork

module Clockwork
  module Holidays
    module Albania

      NEW_YEARS_DAY = Clockwork{|x| c.january & c.mday(1)}
      MOTHERS_DAY_AND_TEACHERS_DAY = Clockwork{|x| c.march & c.mday(7)}
      SULTAN_NOURUZ_REMEMBRANCE = Clockwork{|x| c.march & c.mday(22)}
      LABOUR_DAY = Clockwork{|x| c.may & c.mday(1)}
      MOTHER_TERESA_DAY = Clockwork{|x| c.october & c.mday(19)}
      INDEPENDENCE_DAY = Clockwork{|x| c.november & c.mday(28)}
      CHRISTMAS_DAY = Clockwork{|x| c.december & c.mday(25)}
      INNOCENTS_DAY = Clockwork{|x| c.december & c.mday(28)}

    end
  end

end
