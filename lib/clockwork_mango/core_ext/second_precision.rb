module ClockworkMango
  module CoreExt
    module SecondPrecision
      def usec
        nil
      end
    end # module SecondPrecision
  end # module CoreExt
end # module ClockworkMango

::DateTime.send(:include, ClockworkMango::CoreExt::SecondPrecision)
