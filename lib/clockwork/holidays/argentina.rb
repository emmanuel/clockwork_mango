require "clockwork" unless defined? Clockwork

module Clockwork
  module Holidays
    module Argentina

      NEW_YEARS_DAY = Clockwork{|x| c.january & c.mday(1)}
      LABOUR_DAY = Clockwork{|x| c.may & c.mday(1)}
      ANNIVERSARY_OF_THE_MAY_REVOLUTION = Clockwork{|x| c.may & c.mday(25)}
      FLAG_DAY = Clockwork{|x| c.june & c.mday(20)}
      ANNIVERSARY_OF_THE_ARGENTINE_DECLARATION_OF_INDEPENDENCE = Clockwork{|x| c.july & c.mday(9)}
      TEACHERS_DAY = Clockwork{|x| c.september & c.mday(11)}
      CHRISTMAS_DAY = Clockwork{|x| c.december & c.mday(25)}

    end
  end
end
