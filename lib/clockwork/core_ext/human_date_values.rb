module Clockwork
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
      # @return [Integer] count of Sundays before today in the current year
      # 
      # TODO: spec
      def yweek
        (self.yday - self.wday).div(7)
      end
      
      # how many Sundays are left this year (after today)?
      # (similar to DateTime#cweek)
      # 
      # @return [Integer] negative count of Sundays remaining in the current year
      # 
      # TODO: spec
      def yweek_reverse
        yday_of_following_sunday = self.yday + (7 - self.wday)
        -((self.days_in_year - yday_of_following_sunday).div(7) + 1)
      end
      
      # how many Sundays have occurred this month before today?
      # 
      # @return [Integer] count of Sundays before today in the current month
      # 
      # TODO: spec
      def mweek
        (self.mday - self.wday).div(7) + 1
      end
      
      # how many Sundays are left this month after today?
      # 
      # @return [Integer] negative count of Sundays remaining
      # 
      # TODO: spec
      def mweek_reverse
        mday_of_following_sunday = self.mday + (7 - self.wday)
        -((self.days_in_month - mday_of_following_sunday).div(7) + 1)
      end
      
      # how many of this weekday have occurred this month? For example:
      # If today is Thursday, which Thursday is this (the 1st, 2nd, etc.)?
      # If Monday, which Monday (the 1st, 2nd, 3rd, 4th, etc.)?
      # 
      # considered naming this mwday_ordinal ... is that clearer?
      # 
      # @return [Integer]
      #   count of occurrences of the current weekday in the
      #   current month before today
      # 
      # TODO: spec
      def wday_in_month
        self.mday.div(7) + 1
      end
      
      # how many occurrences of this weekday are left this month?
      # For example:
      #   If today is Thursday, which Thursday is this (the 1st, 2nd, etc.)?
      #   If Monday, which Monday (the 1st, 2nd, 3rd, 4th, etc.)?
      # 
      # considered naming this "mwday_ordinal" ... is that clearer?
      # 
      # @return [Integer] negative count of remaining occurrences of the 
      #   current weekday in the current month
      # 
      # TODO: spec
      def wday_in_month_reverse
        -((self.days_in_month - self.mday).div(7) + 1)
      end
    end # module HumanDateValues
  end # module CoreExt
end # module Clockwork
