require "singleton"
require "active_support/basic_object"
require "clockwork_mango/predicate/base"
require "clockwork_mango/predicate/comparison"
require "clockwork_mango/predicate/compound"

fail "no Predicate::Union" unless defined?(ClockworkMango::Predicate::Union)

module ClockworkMango
  class Loader < ::ActiveSupport::BasicObject
    include ::Singleton

    def self.load(*args)
      instance.__send__(*args)
    end

    def ==(unit, value)
      Predicate::Equality.new(unit, value)
    end

    def >(unit, value)
      Predicate::GreaterThan.new(unit, value)
    end

    def >=(unit, value)
      Predicate::GreaterThanOrEqual.new(unit, value)
    end

    def <(unit, value)
      Predicate::LessThan.new(unit, value)
    end

    def <=(unit, value)
      Predicate::LessThanOrEqual.new(unit, value)
    end

    def |(*expressions)
      Predicate::Union.new(*expressions.map { |e| Loader.load(*e) })
    end

    def &(*expressions)
      Predicate::Intersection.new(*expressions.map { |e| Loader.load(*e) })
    end

    def -(*expressions)
      Predicate::Difference.new(*expressions.map { |e| Loader.load(*e) })
    end

    def >>(expression, unit, value)
      Predicate::Offset.new(Loader.load(*expression), unit, value)
    end
  end
end
