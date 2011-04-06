module ClockworkMango
  module CoreExt
    module Precisioned
      module Date
        def to_temporal_predicate(precision = :day)
          ClockworkMango::Precisioned::Time.new(year, month, mday)
        end
      end

      module Time
        def to_temporal_predicate(precision = :sec)
          ClockworkMango::Precisioned::Time.new(year, month, day, hour, min, sec)
        end
      end
    end # module Precisioned
  end # module CoreExt
end # module ClockworkMango

::Date.send(:include, ClockworkMango::CoreExt::Precisioned::Date)
::DateTime.send(:include, ClockworkMango::CoreExt::Precisioned::Time)
::Time.send(:include, ClockworkMango::CoreExt::Precisioned::Time)
