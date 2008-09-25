module Clockwork
  module CoreExt
    module WeekdayInMonth
      def wday_in_month
        self.mday.div(7) + 1
      end
    end # module WeekdayInMonth
  end # module CoreExt
end # module Clockwork

[::Date, ::Time, ::DateTime].each do |klass|
  klass.send(:include, Clockwork::CoreExt::WeekdayInMonth)
end
