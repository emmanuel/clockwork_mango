module Clockwork
  class Assertion < Expression
    attr_reader :attribute, :value

    def initialize(attribute, value)
      @attribute, @value = attribute, value
      self.define_method(@attribute) { @value }
    end

    def ===(other)
      rval = other.send(@attribute) rescue false
      @value === rval or rval.nil?
    end
  end
end
