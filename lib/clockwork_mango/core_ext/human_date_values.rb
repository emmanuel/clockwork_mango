module ClockworkMango
  module CoreExt
    module HumanDateValues
      MONTH_LENGTHS = [nil, 31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 31, 31]
      # how many days are there in the current month?
      # 
      # @return [Integer] count of total days in the current month
      def days_in_month
        (leap_year? and month == 2) ? MONTH_LENGTHS[month] + 1 : MONTH_LENGTHS[month]
      end
      
      # how many days are there in the current year?
      # 
      # @return [Integer] count of total days in the current year
      def days_in_year
        leap_year? ? 366 : 365
      end

      # is the current year a leap year?
      # 
      # @return [Boolean] true if self.year is a leap year
      def leap_year?
        @leap_year ||= year % 4 == 0 and not year % 100 == 0 or year % 400 == 0
      end

      # how many Sundays have already occurred this year (before today)?
      # (similar to DateTime#cweek)
      # 
      #   DateTime.parse("2011-01-01").yweek # => 0
      #   DateTime.parse("2011-01-03").yweek # => 1
      #   DateTime.parse("2004-02-29").yweek # => 8
      #   DateTime.parse("2010-11-08").yweek # => 44
      # 
      # @return [Integer] count of Sundays before today in the current year
      def yweek
        (self.yday + self.beginning_of_year.wday - 2).div(7)
      end

      # how many Sundays are left this year (after today)?
      # (similar to DateTime#cweek)
      # 
      #   DateTime.parse("2011-01-01").yweek_reverse # => 52
      #   DateTime.parse("2010-11-08").yweek_reverse # => 7
      #   DateTime.parse("2010-12-08").yweek_reverse # => 3
      # 
      # @return [Integer] count of Sundays remaining in the current year
      def yweek_reverse
        last_day_of_year = end_of_year
        yday_of_last_sunday_of_year = last_day_of_year.yday - last_day_of_year.wday
        yday_of_following_sunday = self.yday + (7 - self.wday)
        (yday_of_last_sunday_of_year - yday_of_following_sunday).div(7) + 1
      end

      # how many Sundays have occurred this month before today?
      # 
      #   DateTime.parse("2011-01-01").mweek # => 0
      #   DateTime.parse("2011-01-03").mweek # => 1
      #   DateTime.parse("2004-02-29").mweek # => 4
      #   DateTime.parse("2010-11-08").mweek # => 1
      # 
      # @return [Integer] count of Sundays before today in the current month
      def mweek
        (self.mday + self.beginning_of_month.wday - 1).div(7)
      end

      # how many Sundays are left this month after today?
      # 
      #   DateTime.parse("2011-01-01").mweek_reverse # => 5
      #   DateTime.parse("2011-01-03").mweek_reverse # => 4
      #   DateTime.parse("2004-02-29").mweek_reverse # => 0
      #   DateTime.parse("2010-11-08").mweek_reverse # => 3
      # 
      # @return [Integer] negative count of Sundays remaining
      def mweek_reverse
        mday_of_following_sunday = self.mday + (7 - self.wday)
        ((self.days_in_month - mday_of_following_sunday).div(7) + 1)
      end

      # how many of this weekday have occurred this month? For example:
      # If today is Thursday, which Thursday is this (the 1st, 2nd, etc.)?
      # If Monday, which Monday (the 1st, 2nd, 3rd, 4th, etc.)?
      # 
      # considered naming this mwday_ordinal ... is that clearer?
      # 
      #   DateTime.parse("2011-01-01").wday_in_month # => 1
      #   DateTime.parse("2011-01-03").wday_in_month # => 1
      #   DateTime.parse("2004-02-29").wday_in_month # => 5
      #   DateTime.parse("2010-11-08").wday_in_month # => 2
      # 
      # @return [Integer]
      #   count of occurrences of the current weekday in the
      #   current month before today
      def wday_in_month
        self.mday.div(7) + 1
      end

      # how many occurrences of this weekday are left this month?
      # For example:
      #   If today is Thursday, how many more Thursdays are in this month (1, 2, etc.)?
      #   If Monday, how many Mondays remain (1, 2, 3, 4, etc.)?
      # 
      # considered naming this "mwday_ordinal_reverse" ... is that clearer?
      # 
      #   DateTime.parse("2011-01-01").wday_in_month_reverse # => 4
      #   DateTime.parse("2011-01-03").wday_in_month_reverse # => 4
      #   DateTime.parse("2004-02-29").wday_in_month_reverse # => 0
      #   DateTime.parse("2010-11-08").wday_in_month_reverse # => 3
      #   DateTime.parse("2010-11-18").wday_in_month_reverse # => 1
      # 
      # @return [Integer] negative count of remaining occurrences of the 
      #   current weekday in the current month
      def wday_in_month_reverse
        (self.days_in_month - self.mday).div(7)
      end
    end # module HumanDateValues
  end # module CoreExt
end # module ClockworkMango

::Date.send(    :include, ClockworkMango::CoreExt::HumanDateValues)
::DateTime.send(:include, ClockworkMango::CoreExt::HumanDateValues)
::Time.send(    :include, ClockworkMango::CoreExt::HumanDateValues)
