require "enumerator"

%w[date date_time time].each do |temporal|
  require "active_support/core_ext/#{temporal}/calculations"
end

module ClockworkMango
  module OccurrenceSolver
    def self.next_occurrence(predicate, after = Time.now.utc)
      solver = self.for(predicate)
      solver.next_occurrence(after)
    end

    def self.for(predicate)
      solver_class = solver_class_for(predicate)
      solver_class.new(predicate)
    end

    def self.solver_class_for(predicate)
      if predicate.kind_of?(Predicate)
        solver_name = predicate.class.to_s.split("::").last
        const_get(solver_name)
      else
        raise ArgumentError, "missing occurrence solver for #{predicate.inspect}"
      end
    end

    class Base
      def initialize(predicate)
        @predicate = predicate
      end

      def next_occurrences(limit = 1, after = Time.now.utc)
        Array(1..limit).map do |i|
          # TODO: implement!
          # next_occurrence(after.advance(ATTR_RECURRENCE[@attribute] => i))
        end
      end

      # template method for subclasses
      def next_occurrence(after = Time.now.utc)
        return nil unless recurrence

        occurrence = after.change(next_values)
        # TODO: add support for year multiples (eg., every other year, every 10th year)
        if @attribute == :year and @value < after.year
          nil # years are anchored, they don't recur (on the Gregorian calendar)
        elsif after < occurrence
          occurrence
        else
          begin
            occurrence = occurrence.advance(recurrence)
          end until @predicate === occurrence
          occurrence
        end
      end

    private

      def next_values
        {}
      end

      # must return a hash to be used as the arg to #advance
      def recurrence
        nil
      end
    end # class Base
  end # module OccurrenceSolver
end # module ClockworkMango

require "clockwork_mango/occurrence_solver/comparison"
require "clockwork_mango/occurrence_solver/compound"
