module Clockwork
  module Dsl
    WEEKDAYS = %w(sunday monday tuesday wednesday thursday friday saturday)
    MONTHS = %w(january february march april may june july august september november december)

    def define_arity_zero_expression_builder(name, attribute, value)
    end

    def define_arity_one_expression_builder(name, attribute)
    end

    WEEKDAYS.each_with_index do |wday, index|
      define_arity_zero_expression_builder(wday, :wday, index)
    end

    MONTHS.each_with_index do |month, index|
      define_arity_zero_expression_builder(month, :month, index + 1)
    end
  end
end
