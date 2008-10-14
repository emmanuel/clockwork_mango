require "clockwork" unless defined? Clockwork

module Clockwork
  module Holidays
    module Argentina

      NEW_YEARS_DAY = Clockwork{|c| c.january & c.mday(1)}
      LABOUR_DAY = Clockwork{|c| c.may & c.mday(1)}
      ANNIVERSARY_OF_THE_MAY_REVOLUTION = Clockwork{|c| c.may & c.mday(25)}
      FLAG_DAY = Clockwork{|c| c.june & c.mday(20)}
      ANNIVERSARY_OF_THE_ARGENTINE_DECLARATION_OF_INDEPENDENCE = Clockwork{|c| c.july & c.mday(9)}
      TEACHERS_DAY = Clockwork{|c| c.september & c.mday(11)}
      CHRISTMAS_DAY = Clockwork{|c| c.december & c.mday(25)}

    end
  end
end
