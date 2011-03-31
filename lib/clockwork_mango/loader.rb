require "singleton"
require "active_support/basic_object"
require "clockwork_mango/predicate/base"
require "clockwork_mango/predicate/comparison"
require "clockwork_mango/predicate/compound"

module ClockworkMango
  class Loader < ::ActiveSupport::BasicObject
    include ::Singleton

    def self.load_expression(*args)
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
      Predicate::Union.new(*expressions.map { |e| Loader.load_expression(*e) })
    end

    def &(*expressions)
      Predicate::Intersection.new(*expressions.map { |e| Loader.load_expression(*e) })
    end

    def -(*expressions)
      Predicate::Difference.new(*expressions.map { |e| Loader.load_expression(*e) })
    end

    def >>(expression, unit, value)
      Predicate::Offset.new(Loader.load_expression(*expression), unit, value)
    end

    module LoadMethod
      def load_expression(*args)
        ::ClockworkMango::Loader.load_expression(*args)
      end
    end # module LoadMethod
  end # class Loader

  Predicate.extend(Loader::LoadMethod)
end # module ClockworkMango
