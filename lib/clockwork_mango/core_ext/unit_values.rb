module ClockworkMango
  module CoreExt
    module UnitValues
      module Date
        DAY    = 1.0
        HOUR   = DAY / 24
        MINUTE = HOUR / 60
        SECOND = MINUTE / 60

        YEAR   = 365.25 * DAY
        MONTH  = 30 * DAY

        def unit_value(unit, value)
          case unit
          when :second  ; value.to_f * SECOND
          when :minute  ; value.to_f * MINUTE
          when :hour    ; value.to_f * HOUR
          when :mday    ; value.to_f
          when :month   ; value.to_f * MONTH
          when :year    ; value.to_f * YEAR
          else raise ArgumentError, "invalid unit"
          end
        end
      end

      module Time
        SECOND = 1.0
        MINUTE = 60 * SECOND
        HOUR   = 60 * MINUTE
        DAY    = 24 * HOUR
        MONTH  = 30 * DAY
        YEAR   = 365.25 * DAY
        
        def unit_value(unit, value)
          case unit
          when :second  ; value.to_f
          when :minute  ; value.to_f * MINUTE
          when :hour    ; value.to_f * HOUR
          when :mday    ; value.to_f * DAY
          when :month   ; value.to_f * MONTH
          when :year    ; value.to_f * YEAR
          else raise ArgumentError, "invalid unit"
          end
        end
      end
    end # module IntegerDsl
  end # module CoreExt
end # module ClockworkMango

::Date.send(    :extend, ClockworkMango::CoreExt::UnitValues::Date)
::DateTime.send(:extend, ClockworkMango::CoreExt::UnitValues::Date)
::Time.send(    :extend, ClockworkMango::CoreExt::UnitValues::Time)
