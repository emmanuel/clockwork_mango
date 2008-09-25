module Clockwork
  module Dsl
    WEEKDAYS = %w[sunday monday tuesday wednesday thursday friday saturday]
    MONTHS = %w[january february march april may june july august september november december]

    def self.define_arity_zero_expression_builder(name, attribute, value)
      define_method(name) do
        Assertion.new(attribute, value)
      end
    end

    WEEKDAYS.each_with_index do |wday, index|
      define_arity_zero_expression_builder(wday, :wday, index)
    end

    MONTHS.each_with_index do |month, index|
      define_arity_zero_expression_builder(month, :month, index + 1)
    end

    def self.define_arity_one_expression_builder(name, attribute)
      define_method(name) do |value|
        Assertion.new(attribute, value)
      end
    end
    
    %w[year yweek yday month mday wday wday_in_month hour min sec usec].each do |attribute|
      define_arity_one_expression_builder(attribute, attribute)
    end
  end # module Dsl
end # module Clockwork
