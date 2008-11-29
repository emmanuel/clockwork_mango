module Clockwork
  module CoreExt
    module HumanDateValues
      # how many days are there in the current month?
      # 
      # implementation should be straightforward, but for February
      # 
      # @return [Integer] count of total days in the current month
      def days_in_month
        # cache based? maybe call up to class:
        # self.class.days_in_month(self.year, self.month)
      end
      
      # how many days are there in the current year?
      # 
      # implementation should be straightforward, but for leap years
      # 
      # @return [Integer] count of total days in the current year
      def days_in_year
        # cache based? maybe call up to class:
        # self.class.days_in_year(self.year)
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
      
      # how many Sundays have occurred this month before today?
      # 
      # @return [Integer] count of Sundays before today in the current month, 
      #   or negative count of Sundays remaining, if reverse is true
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
        mday.div(7) + 1
      end
      
      # how many of this weekday have occurred this month? For example:
      # If today is Thursday, which Thursday is this (the 1st, 2nd, etc.)?
      # If Monday, which Monday (the 1st, 2nd, 3rd, 4th, etc.)?
      # 
      # considered naming this mwday_ordinal ... is that clearer?
      # 
      # @return [Integer] negative count of remaining occurrences of the 
      #   current weekday in the current month
      # 
      # TODO: spec
      def wday_in_month_reverse
        -((self.days_in_month - mday).div(7) + 1)
      end
    end # module HumanDateValues
  end # module CoreExt
end # module Clockwork
