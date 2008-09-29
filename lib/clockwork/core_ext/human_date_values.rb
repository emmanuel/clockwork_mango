module Clockwork
  module CoreExt
    module HumanDateValues
      # how many days are there in the current month?
      # 
      # implementation should be straightforward, but for February
      # 
      # @return <Integer> count of total days in the current month
      def days_in_month
        # cache based? maybe call up to class:
        # self.class.days_in_month(self.year, self.month)
      end
      
      # how many days are there in the current year?
      # 
      # implementation should be straightforward, but for leap years
      # 
      # @return <Integer> count of total days in the current year
      def days_in_month
        # cache based? maybe call up to class:
        # self.class.days_in_year(self.year)
      end
      
      # how many Sundays have occurred this year before today?
      # (similar to DateTime#cweek)
      # 
      # @param reverse <Boolean> when true, calculates the reverse: 
      #   is this the last week of the year? 2nd to last?
      # 
      # @return <Integer> count of Sundays before today in the current year, 
      #   or negative count of Sundays remaining, if reverse is true
      # 
      # TODO: spec
      def yweek(reverse=false)
        yday_of_preceding_sunday = self.yday - self.wday
        if reverse
          -((self.days_in_year - yday_of_preceding_sunday).div(7) + 1)
        else
          yday_of_preceding_sunday.div(7)
        end
      end
      
      # how many Sundays have occurred this month before today?
      # 
      # @param reverse <Boolean> when true, calculates the reverse: 
      #   is this the last week of the month? 2nd to last? 
      # 
      # @return <Integer> count of Sundays before today in the current month, 
      #   or negative count of Sundays remaining, if reverse is true
      # 
      # TODO: spec
      def mweek(reverse=false)
        mday_of_preceding_sunday = self.mday - self.wday
        if reverse
          -((self.days_in_month - mday_of_preceding_sunday).div(7) + 1)
        else
          mday_of_preceding_sunday.div(7) + 1
        end
      end
      
      # how many of this weekday have occurred this month? For example:
      # If today is Thursday, which Thursday is this (the 1st, 2nd, etc.)?
      # If Monday, which Monday (the 1st, 2nd, 3rd, 4th, etc.)?
      # 
      # considered naming this mwday_ordinal ... is that clearer?
      # 
      # @param reverse <Boolean> when true, calculates the reverse: 
      #   is this the last Monday of the month? 2nd to last Thursday?
      # 
      # @return <Integer> count of occurrences of the current weekday in the 
      #   current month before today, or negative count of remaining 
      #   occurrences, if reverse is true
      # 
      # TODO: spec
      def wday_in_month(reverse=false)
        if reverse
          -((self.days_in_month - mday).div(7) + 1)
        else
          mday.div(7) + 1
        end
      end
    end # module HumanDateValues
  end # module CoreExt
end # module Clockwork
