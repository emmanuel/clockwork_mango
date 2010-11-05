require "active_support/concern"

module ClockworkMango
  module CoreExt
    module DayPrecision
      extend ActiveSupport::Concern

      included do
        # TODO: make this conditional so it doesn't blow up if it gets 
        #   included in unanticipated places
        alias_method :hour_with_private, :hour # if instance_methods.include?(:hour)
        alias_method :min_with_private,  :min  # if instance_methods.include?(:min)
        alias_method :sec_with_private,  :sec  # if instance_methods.include?(:sec)

        def hour
          nil
        end

        alias_method :min,  :hour
        alias_method :sec,  :hour
        alias_method :usec, :hour

        public :hour
        public :min
        public :sec
        public :usec
      end
    end # module DayPrecision

    module DayPrecisionRemover
      extend ActiveSupport::Concern

      included do
        # TODO: make this conditional so it doesn't blow up if it gets 
        #   included in unanticipated places
        alias_method :hour, :hour_with_private # if instance_methods.include?(:original_hour)
        alias_method :min,  :min_with_private  # if instance_methods.include?(:original_min)
        alias_method :sec,  :sec_with_private  # if instance_methods.include?(:original_sec)

        public :hour
        public :min
        public :sec
        public :usec
      end
    end # module DayPrecisionRemover
  end # module CoreExt
end # module ClockworkMango

::Date.send(    :include, ClockworkMango::CoreExt::DayPrecision)
::DateTime.send(:include, ClockworkMango::CoreExt::DayPrecisionRemover)