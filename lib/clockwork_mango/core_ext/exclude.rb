module ClockworkMango
  module CoreExt
    module Exclude
      def exclude?(value)
        !include?(value)
      end
    end
  end
end

::Array.send(:include, ClockworkMango::CoreExt::Exclude)
::Range.send(:include, ClockworkMango::CoreExt::Exclude)
