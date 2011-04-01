require "spec_helper"
require "clockwork_mango/predicate/comparison"
require "clockwork_mango/predicate/compound"

module ClockworkMango
  describe Predicate::Compound do
    let(:time)     { Time.local(*TIME_ATTRIBUTES.map { |a| VALUES[a] }) }
    let(:datetime) { DateTime.new(*DATETIME_ATTRS.map { |a| VALUES[a] }) }
    let(:date)     { Date.new(*DATE_ATTRIBUTES.map { |a| VALUES[a] }) }

    let(:year_08) { Predicate::Equality.new(:year, 2008) }
    let(:month)   { Predicate::Equality.new(:month, 9) }
    let(:day)     { Predicate::Equality.new(:day, 24) }

    let(:hour) { Predicate::Equality.new(:hour, 18) }
    let(:min)  { Predicate::Equality.new(:min, 30) }
    let(:sec)  { Predicate::Equality.new(:sec, 15) }

    let(:yday)  { Predicate::Equality.new(:yday, 268) }
    let(:yweek) { Predicate::Equality.new(:day, 0) }
    let(:wday)  { Predicate::Equality.new(:wday, 3) }
  end # describe Predicate::Compound::Base
end # module ClockworkMango
