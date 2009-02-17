require "clockwork" unless defined? Clockwork

module Clockwork

  module Holidays
    module Bermuda


      NEW_YEARS_DAY = Clockwork{|c| c.january & c.mday(1)}
      #variable dates (April 6, 2007) - Good Friday
      BERMUDA_DAY = Clockwork{|c| c.may & c.mday(24)}
      QUEENS_BIRTHDAY = Clockwork{|c| c.june & c.mday(11)}
      TRIANGLE_DAY = Clockwork{|c| c.july & c.mday(19)}
      #Thursday before the first Monday in August (August 2, 2007) - Emancipation Day (first Day of Cup Match)
      #Friday before the first Monday in August (August 3, 2007) - Somer's Day (Second day of Cup Match)
      #First Monday in September (September 3, 2007) - Labour Day
      REMEMBRANCE_DAY = Clockwork{|c| c.november & c.mday(11)}
      CHRISTMAS_DAY = Clockwork{|c| c.december & c.mday(25)}
      BOXING_DAY = Clockwork{|c| c.december & c.mday(26)}
      extend HolidayMixin

    end
  end

end
