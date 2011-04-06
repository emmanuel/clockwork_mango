require "clockwork_mango/predicate"
require "clockwork_mango/predicate/comparison"
require "clockwork_mango/predicate/compound"
require "clockwork_mango/unroll"

# Shortcut to the ClockworkMango::Dsl.build_predicate dsl. 
# Lets you use the lib from any context like so:
#   Clockwork { |c| c.november & c.wday_in_month(1) & c.monday }
# or without the block variable (instance_eval'd, so self is switched!):
#   Clockwork { november & wday_in_month(1) & monday }
# Both of which will return a ClockworkMango::Predicate object, with a #=== method
#   which matches objects that represent the 1st Monday in November
# 
# @param block <Block> will be yielded ClockworkMango::Dsl as a parameter,
#   or instance_eval'd in the context of ClockworkMango::Dsl if arity zero
# 
# @return <ClockworkMango::Predicate> defined by the provided block
def Clockwork(&block)
  ::ClockworkMango::Dsl.build_predicate(&block)
end

module ClockworkMango
  module Dsl
    extend self

    def build_predicate(&block)
      # TODO: why do I get arity -1 with `Clockwork { monday(3) }`?
      # if block.arity.zero?
      if block.arity != 1
        instance_eval(&block)
      else
        yield(self)
      end
    end

    # Adds a method to the Dsl that will accept a single argument
    # 
    # @param name<String, Symbol> the name of the method to create
    # @param attribute<String, Symbol> the attribute that will be asserted
    def define_arity_one_predicate_builder(name, attribute)
      name, attribute = name.to_sym, attribute.to_sym
      define_method(name) do |value|
        if value.respond_to?(:include?)
          Predicate::Inclusion.new(attribute, value)
        else
          Predicate::Equality.new(attribute, value)
        end
      end
    end

    private :define_arity_one_predicate_builder

    Constants::COMPARABLE_ATTRIBUTES.each do |attribute|
      define_arity_one_predicate_builder(attribute, attribute)
    end

    # Build a predicate that matches the named month (and optional month day)
    # 
    # @param [Integer] month_day (optional)
    #   define intersecting :day Predicate::Equality if provided.
    #   If no month_day value is provided, no :day predicate will be intersected
    # 
    # @return [ClockworkMango::Predicate::Equality, ClockworkMango::Predicate::Intersection]
    #   a :month Predicate::Equality (if no month_day provided), or
    #   an Predicate::Intersection of :month and :day (if month_day provided)
    Constants::MONTHS.each_with_index do |month, index|
      module_eval <<-RUBY, __FILE__, __LINE__
        def #{month}(month_day=nil)
          if month_day
            month(#{index + 1}) & day(month_day)
          else
            month(#{index + 1})
          end
        end
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
    #   define intersecting :wday_in_month Predicate::Equality if provided.
    #   Symbols will be used to look up an integer value in ORDINAL_MAP.
    #   If no value is found, no :wday_in_month predicate will be intersected
    # 
    # @return [ClockworkMango::Predicate::Equality, ClockworkMango::Predicate::Intersection]
    #   a :wday Predicate::Equality or
    #   an Predicate::Intersection of :wday & :wday_in_month/:wday_in_year
    #   (:wday & :wday_in_month) if ordinal provided and ordinal_scope == :month (default)
    #   (:wday & :wday_in_year) if ordinal provided and ordinal_scope == :year
    # 
    # TODO: make the :wday_in_month/:wday_in_year invocation a bit more explicit, eg:
    #   monday(:wday_in_month => 3)
    #   monday(:in_month => 3)        # this is my front-runner so far
    #   monday(:month => 3)
    # 
    Constants::WEEKDAYS.each_with_index do |wday, index|
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
    end

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
    # @return [ClockworkMango::Predicate::Equality, ClockworkMango::Predicate::Intersection]
    #   a Predicate that matches the given time of day, at the precision of the provided args
    def at(hh, mm = nil, ss = nil)
      Unroll.validate_hhmmss(hh,mm,ss)

      if mm.nil?
        hour(hh)
      elsif ss.nil?
        hour(hh) & min(mm)
      else
        hour(hh) & min(mm) & sec(ss)
      end
    end

    def until(hh, mm = nil, ss = nil)
      Unroll.validate_hhmmss(hh,mm,ss)

      if mm.nil?
        Predicate::LessThanOrEqual.new(:hour, hh)
      elsif ss.nil?
        Predicate::LessThan.new(:hour, hh) | (
          Predicate::Equality.new(:hour, hh) &
          Predicate::LessThanOrEqual.new(:min, mm))
      else
        Predicate::LessThan.new(:hour, hh) | (
          Predicate::Equality.new(:hour, hh) & (
            Predicate::LessThan.new(:min, mm) | (
            Predicate::Equality.new(:min, mm) & Predicate::LessThanOrEqual.new(:sec, ss))))
      end
    end

    def from(*args)
      if args.length == 1 and args.first.is_a?(Range)
        time_range = args.first
        Unroll.validate_time_range(time_range)
        Unroll.time_range(time_range)
      else
        hh, mm, ss = args
        Unroll.validate_hhmmss(hh, mm, ss)
        Unroll.hhmmss(hh, mm, ss)
      end
    end

  end # module Dsl

  module Predicate
    def from(*args)
      Predicate::Intersection.new(self, Dsl.from(*args))
    end

    def at(*args)
      Predicate::Intersection.new(self, Dsl.at(*args))
    end
  end

end # module ClockworkMango
