require "date"
require "time"

require Clockwork::LIBDIR + "clockwork/core_ext/day_precision"
::Date.send(:include, Clockwork::CoreExt::DayPrecision)
::DateTime.send(:include, Clockwork::CoreExt::DayPrecisionRemover)

require Clockwork::LIBDIR + "clockwork/core_ext/second_precision"
::DateTime.send(:include, Clockwork::CoreExt::SecondPrecision)

require Clockwork::LIBDIR + "clockwork/core_ext/human_date_values"
[::Date, ::Time, ::DateTime].each do |klass|
  klass.send(:include, Clockwork::CoreExt::HumanDateValues)
end

