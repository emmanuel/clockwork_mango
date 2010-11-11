require "clockwork_mango"

module ClockworkMango
  module Holidays
    module Bhutan
      extend HolidayCollection

      #(lunar) - Offerings Day
      #(lunar) - Losay (Lunar New Year)
      THE_KINGS_BIRTHDAY = Clockwork { may(2) }
      #(lunar) - Shabdrung Kuchoe (death anniversary of the Shabdrung)
      #(lunar) - Third King's Birthday
      CORONATION_DAY     = Clockwork { june(2) }
      #(lunar) - Buddha Parinirvana
      #(lunar) - Buddha's First Sermon
      #(lunar) - Third King's Death
      #(lunar) - Guru Rinpoche's Birthday
      #(lunar) - Blessed Rainy Day
      #(lunar) - Dashaim
      #(lunar) - Buddha Descension Day
      NATIONAL_DAY       = Clockwork { december(17) }
      WINTER_SOLSTICE    = Clockwork { december(21) }

    end
  end
end
