require "clockwork" unless defined? Clockwork

module Clockwork
  module Holidays
    module Bhutan

      #(lunar) - Offerings Day
      #(lunar) - Losay (Lunar New Year)
      THE_KINGS_BIRTHDAY = Clockwork{|c| c.may & c.mday(2)}
      #(lunar) - Shabdrung Kuchoe (death anniversary of the Shabdrung)
      #(lunar) - Third King's Birthday
      CORONATION_DAY = Clockwork{|c| c.june & c.mday(2)}
      #(lunar) - Buddha Parinirvana
      #(lunar) - Buddha's First Sermon
      #(lunar) - Third King's Death
      #(lunar) - Guru Rinpoche's Birthday
      #(lunar) - Blessed Rainy Day
      #(lunar) - Dashaim
      #(lunar) - Buddha Descension Day
      NATIONAL_DAY = Clockwork{|c| c.december & c.mday(17)}
      WINTER_SOLSTICE = Clockwork{|c| c.december & c.mday(21)}
      extend HolidayMixin

    end
  end

end
