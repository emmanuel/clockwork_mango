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
# @param block [Block] will be yielded ClockworkMango::Dsl as a parameter,
#   or instance_eval'd in the context of ClockworkMango::Dsl if arity zero
# 
# @return [ClockworkMango::Predicate] defined by the provided block
def Clockwork(&block)
  ::ClockworkMango::Dsl.build_predicate(&block)
end

module ClockworkMango
  class Dsl
    def self.build_predicate(&block)
      raise ArgumentError, "expected block arg" unless block_given?
      # TODO: why do I get arity -1 with `Clockwork { monday(3) }`?
      # if block.arity.zero?
      block.arity == 1 ? yield(new) : new.instance_eval(&block)
    end

    # Adds a method to the Dsl that will accept a single argument
    # 
    # @param name<String, Symbol> the name of the method to create
    # @param attribute<String, Symbol> the attribute that will be asserted
    def self.define_arity_one_predicate_builder(name, attribute)
      module_eval <<-RUBY, __FILE__, __LINE__
        def #{name}(value)
          if value.respond_to?(:include?)
            Predicate::Inclusion.new(:#{attribute}, value)
          else
            Predicate::Equality.new(:#{attribute}, value)
          end
        end

        def self.#{name}(*args)
          new.#{name}(*args)
        end
      RUBY
    end

    Constants::COMPARABLE_ATTRIBUTES.each do |attribute|
      define_arity_one_predicate_builder(attribute, attribute)
    end

    # Build a predicate that matches the named month (and optional month day)
    # 
    # @param [Integer] month_day (optional)
    #   define intersecting :mday Predicate::Equality if provided.
    #   If no month_day value is provided, no :mday predicate will be intersected
    # 
    # @return [ClockworkMango::Predicate::Equality, ClockworkMango::Predicate::Intersection]
    #   a :month Predicate::Equality (if no month_day provided), or
    #   an Predicate::Intersection of :month and :mday (if month_day provided)
    Constants::MONTHS.each_with_index do |month, index|
      module_eval <<-RUBY, __FILE__, __LINE__
        def #{month}(month_day=nil)
          if month_day
            month(#{index + 1}) & mday(month_day)
          else
            month(#{index + 1})
          end
        end

        def self.#{month}(*args)
          new.#{month}(*args)
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

    # 
    # TODO: make the :wday_in_month/:wday_in_year invocation a bit more explicit, eg:
    #   monday(:wday_in_month => 3)
    #   monday(:in_month => 3)        # this is my front-runner so far
    #   monday(:month => 3)
    # 
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

        def self.#{wday}(*args)
          new.#{wday}(*args)
        end

        def self.#{wday}s(*args)
          new.#{wday}(*args)
        end
      RUBY
      alias_method :"#{wday}s", :"#{wday}"
    end

    # 
    # TODO: replace #at, #from, #hhmmss_or_later, #until, & #after with PrecisionedTime
    # 
    # 
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

    def self.at(*args)
      new.at(*args)
    end

    def from(*args)
      if args.length == 1 and args.first.is_a?(Range)
        Unroll.time_range(args.first)
      else
        hhmmss_or_later(*args)
      end
    end

    def self.from(*args)
      new.from(*args)
    end

    def hhmmss_or_later(hh, mm = nil, ss = nil)
      Unroll.validate_hhmmss(hh, mm, ss)

      if mm.nil?
        Predicate::GreaterThanOrEqual.new(:hour, hh)
      elsif ss.nil?
        Predicate::GreaterThan.new(:hour, hh) | (
          Predicate::Equality.new(:hour, hh) &
          Predicate::GreaterThanOrEqual.new(:min, mm))
      else
        Predicate::GreaterThan.new(:hour, hh) | (
          Predicate::Equality.new(:hour, hh) & (
            Predicate::GreaterThan.new(:min, mm) | (
              Predicate::Equality.new(:min, mm) &
              Predicate::GreaterThanOrEqual.new(:sec, ss))))
      end
    end

    def until(hh, mm = nil, ss = nil)
      Unroll.validate_hhmmss(hh,mm,ss)

      if mm.nil?
        Predicate::LessThan.new(:hour, hh)
      elsif ss.nil?
        Predicate::LessThan.new(:hour, hh) | (
          Predicate::Equality.new(:hour, hh) &
          Predicate::LessThan.new(:min, mm))
      else
        Predicate::LessThan.new(:hour, hh) | (
          Predicate::Equality.new(:hour, hh) & (
            Predicate::LessThan.new(:min, mm) | (
              Predicate::Equality.new(:min, mm) &
              Predicate::LessThan.new(:sec, ss))))
      end
    end

    def self.until(*args)
      new.until(*args)
    end

    def after(hh, mm = nil, ss = nil)
      Unroll.validate_hhmmss(hh,mm,ss)

      if mm.nil?
        Predicate::GreaterThan.new(:hour, hh)
      elsif ss.nil?
        Predicate::GreaterThan.new(:hour, hh) | (
          Predicate::Equality.new(:hour, hh) &
          Predicate::GreaterThan.new(:min, mm))
      else
        Predicate::GreaterThan.new(:hour, hh) | (
          Predicate::Equality.new(:hour, hh) & (
            Predicate::GreaterThan.new(:min, mm) | (
              Predicate::Equality.new(:min, mm) &
              Predicate::GreaterThan.new(:sec, ss))))
      end
    end

    def self.after(*args)
      new.after(*args)
    end

  end # module Dsl

  module Predicate
    def at(*args)
      Predicate::Intersection.new(self, Dsl.at(*args))
    end

    def from(*args)
      Predicate::Intersection.new(self, Dsl.from(*args))
    end

    def until(*args)
      Predicate::Intersection.new(self, Dsl.until(*args))
    end

    def after(*args)
      Predicate::Intersection.new(self, Dsl.after(*args))
    end
  end

end # module ClockworkMango
