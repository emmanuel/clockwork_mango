module Clockwork
  module CoreExt
    module DayPrecision
      def hour
        nil
      end

      alias_method :min,  :hour
      alias_method :sec,  :hour
      alias_method :usec, :hour
    end # module DayPrecision
  end # module CoreExt
end # module Clockwork

Date.send(:include, Clockwork::CoreExt::DayPrecision)
