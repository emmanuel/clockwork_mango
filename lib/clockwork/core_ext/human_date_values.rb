module Clockwork
  module CoreExt
    module HumanDateValues
      # how many Sundays have occurred this year before today?
      # (similar to DateTime#cweek)
      # 
      # @param reverse <Boolean> when true, calculates the reverse: 
      #   is this the last week of the year? 2nd to last?
      # 
      # @return <Integer> count of Sundays before today in the current year, 
      #   or Sundays remaining if reverse is true
      # 
      # TODO: spec
      def yweek(reverse=false)
        preceding_sunday_yday = self.yday - self.wday
        if reverse
          -((days_in_year - preceding_sunday_yday).div(7) + 1)
        else
          preceding_sunday_yday.div(7)
        end
      end
      
      # how many Sundays have occurred this month before today?
      # 
      # @param reverse <Boolean> when true, calculates the reverse: 
      #   is this the last week of the month? 2nd to last? 
      # 
      # @return <Integer> count of Sundays before today in the current month, 
      #   or negative count of Sundays remaining after preceding Sunday
      # 
      # TODO: spec
      def mweek(reverse=false)
        preceding_sunday_mday = self.mday - self.wday
        if reverse
          -((days_in_month - mday_of_previous_sunday).div(7) + 1)
        else
          preceding_sunday_mday.div(7) + 1
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
      #   current month before today, or remaining occurrences of the current 
      #   weekday in the month if reverse is true
      # 
      # TODO: spec reverse
      def wday_in_month(reverse=false)
        if reverse
          -((days_in_month - mday).div(7) + 1)
        else
          mday.div(7) + 1
        end
      end
    end # module HumanDateValues
  end # module CoreExt
end # module Clockwork
