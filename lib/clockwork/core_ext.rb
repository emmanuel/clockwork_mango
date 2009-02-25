require "date"
require "time"

require "active_support/basic_object"
require "active_support/duration"
require "active_support/core_ext/object"
require "active_support/core_ext/date"
require "active_support/core_ext/date_time"
require "active_support/core_ext/time"

require "clockwork/core_ext/day_precision"
::Date.send(    :include, Clockwork::CoreExt::DayPrecision)
::DateTime.send(:include, Clockwork::CoreExt::DayPrecisionRemover)

require "clockwork/core_ext/second_precision"
::DateTime.send(:include, Clockwork::CoreExt::SecondPrecision)

require "clockwork/core_ext/human_date_values"
::Date.send(    :include, Clockwork::CoreExt::HumanDateValues)
::DateTime.send(:include, Clockwork::CoreExt::HumanDateValues)
::Time.send(    :include, Clockwork::CoreExt::HumanDateValues)

require "clockwork/core_ext/unit_values"
::Date.send(    :extend, Clockwork::CoreExt::UnitValues::Date)
::DateTime.send(:extend, Clockwork::CoreExt::UnitValues::Date)
::Time.send(    :extend, Clockwork::CoreExt::UnitValues::Time)
