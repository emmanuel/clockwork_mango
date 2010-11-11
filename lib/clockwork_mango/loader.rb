require "singleton"
require "active_support/basic_object"

module ClockworkMango
  class Loader < ::ActiveSupport::BasicObject
    include ::Singleton

    def self.load(*args)
      instance.__send__(*args)
    end

    def ==(unit, value)
      EqualityPredicate.new(unit, value)
    end

    def >(unit, value)
      GreaterThanPredicate.new(unit, value)
    end

    def >=(unit, value)
      GreaterThanOrEqualPredicate.new(unit, value)
    end

    def <(unit, value)
      LessThanPredicate.new(unit, value)
    end

    def <=(unit, value)
      LessThanOrEqualPredicate.new(unit, value)
    end

    def |(*expressions)
      UnionPredicate.new(*expressions.map { |e| Loader.load(*e) })
    end

    def &(*expressions)
      IntersectionPredicate.new(*expressions.map { |e| Loader.load(*e) })
    end

    def -(*expressions)
      DifferencePredicate.new(*expressions.map { |e| Loader.load(*e) })
    end

    def >>(expression, unit, value)
      OffsetPredicate.new(Loader.load(*expression), unit, value)
    end
  end
end
