module ClockworkMango
  module CoreExt
    module PrecisionedDate
      def to_temporal_predicate
        ClockworkMango::Precisioned::Date.new(self)
      end
    end

    module PrecisionedTime
      def to_temporal_predicate
        ClockworkMango::Precisioned::Time.new(self)
      end
    end
  end
end

::Date.send(:include, ClockworkMango::CoreExt::PrecisionedDate)
::DateTime.send(:include, ClockworkMango::CoreExt::PrecisionedTime)
::Time.send(:include, ClockworkMango::CoreExt::PrecisionedTime)
