module Clockwork
  module CoreExt
    module HumanDateValues
      # how many Sundays have occurred this year before today?
      # (similar to DateTime#cweek)
      def yweek
        (yday - wday).div(7)
      end

      # is this the last week of the year? 2nd to last?
      # TODO: implement and test
      def yweek_reverse
        nil
      end
      
      # how many of this weekday have already passed in the current month?
      # eg., is this the 1st Thursday? 2nd Monday?
      # considered naming this mwday_ordinal ... is that clearer?
      def wday_in_month
        mday.div(7) + 1
      end
      
      # is this the last Monday of the month? 2nd to last Thursday?
      # TODO: implement and test
      def wday_in_month_reverse
        nil
      end
    end # module HumanDateValues
  end # module CoreExt
end # module Clockwork

[::Date, ::Time, ::DateTime].each do |klass|
  klass.send(:include, Clockwork::CoreExt::HumanDateValues)
end
