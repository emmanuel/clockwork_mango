# pick your poison:
require "rubygems"
# Bundler.setup(:default, :test)

# Wed Sep 24 18:30:15 -0700 2008, 500 usec
VALUES = {
  :year  => 2008,
  :month => 9,
  :day   => 24,
  :hour  => 18,
  :min   => 30,
  :sec   => 15,
  :usec  => 500,
  :yday  => 268,
  :yweek => 3,
  :wday  => 3,
  :wday_in_month => 4,
}

RSpec::Matchers.define :express do |expression|
  if expression.respond_to?(:to_temporal_sexp)
    expression = expression.to_temporal_sexp
  end
  match do |predicate|
    if predicate.respond_to?(:to_temporal_sexp)
      predicate.to_temporal_sexp.should == expression
    else
      predicate.should == expression
    end
  end
end
