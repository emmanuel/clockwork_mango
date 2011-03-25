require "clockwork_mango/predicate"
require "clockwork_mango/comparison_predicate"
require "clockwork_mango/compound_predicate"
require "clockwork_mango/unroll"

module ClockworkMango
  module Dsl
    def self.build_predicate(&block)
      if block.arity.zero?
        instance_eval(&block)
      else
        yield(self)
      end
    end

    # Adds a method to the Dsl that will accept a single argument
    # 
    # @param name<String, Symbol> the name of the method to create
    # @param attribute<String, Symbol> the attribute that will be asserted
    def self.define_arity_one_predicate_builder(name, attribute)
      name, attribute = name.to_sym, attribute.to_sym
      define_method(name) do |value|
        if value.respond_to?(:include?)
          InclusionPredicate.new(attribute, value)
        else
          EqualityPredicate.new(attribute, value)
        end
      end
      module_function(name)
    end

    # Adds a method to the Dsl that will not accept an argument
    # 
    # @param name<String, Symbol> the name of the method to create
    # @param attribute<String, Symbol> the attribute that will be asserted
    # @param value<Integer, Range> the value of the attribute predicate
    def self.define_arity_zero_predicate_builder(name, attribute, value)
      name, attribute = name.to_sym, attribute.to_sym
      if value.respond_to?(:include?)
        define_method(name) do
          InclusionPredicate.new(attribute, value)
        end
      else
        define_method(name) do
          EqualityPredicate.new(attribute, value)
        end
      end

      module_function(name)
    end

    COMPARABLE_ATTRIBUTES.each do |attribute|
      define_arity_one_predicate_builder(attribute, attribute)
    end

    MONTHS = %w[january february march april may june 
      july august september october november december]

    # Build a predicate that matches the named month (and optional month day)
    # 
    # @param [Integer] month_day (optional)
    #   define intersecting :day EqualityPredicate if provided.
    #   If no month_day value is provided, no :day predicate will be intersected
    # 
    # @return [ClockworkMango::EqualityPredicate, ClockworkMango::IntersectionPredicate]
    #   a :month EqualityPredicate (if no month_day provided), or
    #   an IntersectionPredicate of :month and :day (if month_day provided)
    MONTHS.each_with_index do |month, index|
      module_eval <<-RUBY, __FILE__, __LINE__
        def #{month}(month_day=nil)
          if month_day
            month(#{index + 1}) & day(month_day)
          else
            month(#{index + 1})
          end
        end

        module_function :#{month}
      RUBY
    end

    ORDINAL_MAP = {
      :first  => 1,
      :second => 2,
      :third  => 3,
      :fourth => 4,
      :fifth  => 5,

      :last   => -1,
      :second_to_last => -2,
    }
    # Build a predicate that matches the named weekday.
    # 
    # @param [Integer, Symbol] ordinal (optional)
    #   define intersecting :wday_in_month EqualityPredicate if provided.
    #   Symbols will be used to look up an integer value in ORDINAL_MAP.
    #   If no value is found, no :wday_in_month predicate will be intersected
    # 
    # @return [ClockworkMango::EqualityPredicate, ClockworkMango::IntersectionPredicate]
    #   a :wday EqualityPredicate or
    #   an IntersectionPredicate of :wday & :wday_in_month/:wday_in_year
    #   (:wday & :wday_in_month) if ordinal provided and ordinal_scope == :month (default)
    #   (:wday & :wday_in_year) if ordinal provided and ordinal_scope == :year
    WEEKDAYS = %w[sunday monday tuesday wednesday thursday friday saturday]
    WEEKDAYS.each_with_index do |wday, index|
      module_eval <<-RUBY, __FILE__, __LINE__
        def #{wday}(ordinal=nil, ordinal_scope=:month)
          ordinal = ORDINAL_MAP[ordinal] if ordinal.is_a?(Symbol)
          wday_assertion = wday(#{index})
          if ordinal
            case ordinal_scope
            when :month
              wday_assertion & wday_in_month(ordinal)
            when :year
              wday_assertion & wday_in_year(ordinal)
            end
          else
            wday_assertion
          end
        end
      RUBY
      alias_method :"#{wday}s", :"#{wday}"
      module_function :"#{wday}", :"#{wday}s"
    end

    module_function

    # Builds a Predicate that will match the given time of day, 
    #   at the given precision (hour, minute, or second)
    # 
    #   now = Time.now
    #   predicate = ClockworkMango::Dsl.at(9,15)
    #   predicate === Time.utc(now.year, now.month, now.day, 9, 15)  #=> true
    # 
    # @param [Integer[, Integer[, Integer]]] time_array
    #   an array of hour[, minute[, second]] Integer values
    # 
    # @return [ClockworkMango::EqualityPredicate, ClockworkMango::IntersectionPredicate]
    #   a Predicate that matches the given time of day, at the precision of the provided args
    def at(hh, mm = nil, ss = nil)
      ClockworkMango::Unroll.validate_hhmmss(hh,mm,ss)

      if mm.nil?
        hour(hh)
      elsif ss.nil?
        hour(hh) & min(mm)
      else
        hour(hh) & min(mm) & sec(ss)
      end
    end

    def until(hh, mm = nil, ss = nil)
      ClockworkMango::Unroll.validate_hhmmss(hh,mm,ss)

      if mm.nil?
        LessThanOrEqualPredicate.new(:hour, hh)
      elsif ss.nil?
        LessThanPredicate.new(:hour, hh) | (
          EqualityPredicate.new(:hour, hh) &
          LessThanOrEqualPredicate.new(:min, mm))
      else
        LessThanPredicate.new(:hour, hh) | (
          EqualityPredicate.new(:hour, hh) & (
            LessThanPredicate.new(:min, mm) | (
            EqualityPredicate.new(:min, mm) & LessThanOrEqualPredicate.new(:sec, ss))))
      end
    end

    def from(*args)
      if args.length == 1 and args.first.is_a?(Range)
        time_range = args.first
        ClockworkMango::Unroll.validate_time_range(time_range)
        ClockworkMango::Unroll.time_range(time_range)
      else
        hh, mm, ss = args
        ClockworkMango::Unroll.validate_hhmmss(hh, mm, ss)
        ClockworkMango::Unroll.hhmmss(hh, mm, ss)
      end
    end

    module PredicateExtensions
      def from(*args)
        IntersectionPredicate.new(self, Dsl.from(*args))
      end

      def at(*args)
        IntersectionPredicate.new(self, Dsl.at(*args))
      end
    end

    Predicate.send(:include, PredicateExtensions)

  end # module Dsl
end # module ClockworkMango
