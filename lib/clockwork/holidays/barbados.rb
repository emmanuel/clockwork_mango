require "clockwork" unless defined? Clockwork

module Clockwork
  module Holidays
    module Barbados

      NEW_YEARS_DAY = Clockwork{|c| c.january & c.mday(1)}
      ERROL_BARROW_DAY = Clockwork{|c| c.january & c.mday(21)}
      #Good Friday
      #Easter Monday
      NATIONAL_HEROESDAY = Clockwork{|c| c.april & c.mday(28)}
      #1st Monday of May-Labour Day
      #Whit Monday
      #1st Monday in August-Kadooment Day
      EMANCIPATION_DAY = Clockwork{|c| c.august & c.mday(1)}
      INDEPENDENCE_DAY = Clockwork{|c| c.november & c.mday(30)}
      CHRISTMAS_DAY = Clockwork{|c| c.december & c.mday(25)}
      BOXING_DAY = Clockwork{|c| c.december & c.mday(26)}
      #BOXING_DAY = Clockwork{|c| c.december & c.mday(27)}
      extend HolidayMixin

    end
  end
end
