require "clockwork_mango"

module ClockworkMango
  module Holidays
    module Cyprus
      extend HolidayCollection

      NEW_YEARS_DAY = Clockwork{|c| c.january & c.mday(1)}
      #Good Friday, Easter Sunday and Easter Monday - variable dates
      GREEK_INDEPENDENCE_DAY = Clockwork{|c| c.march & c.mday(25)}
      CYPRUS_NATIONAL_DAY = Clockwork{|c| c.april & c.mday(1)}
      LABOUR_DAY = Clockwork{|c| c.may & c.mday(1)}
      ASSUMPTION_OF_MARY = Clockwork{|c| c.august & c.mday(15)}
      CYPRUS_INDEPENDENCE_DAY = Clockwork{|c| c.october & c.mday(1)}
      CHRISTMAS_DAY = Clockwork{|c| c.december & c.mday(25)}
      BOXING_DAY = Clockwork{|c| c.december & c.mday(26)}

    end
  end
end
