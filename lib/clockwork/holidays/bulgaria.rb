require "clockwork" unless defined? Clockwork

module Clockwork
  module Holidays
    module Bulgaria


      NEW_YEARS_DAY = Clockwork{|x| c.january & c.mday(1)}
      LIBERATION_OF_BULGARIA = Clockwork{|x| c.march & c.mday(3)}
      #Easter Monday - moveable
      LABOUR_DAY = Clockwork{|x| c.may & c.mday(1)}
      ST_GEORGES_DAY = Clockwork{|x| c.may & c.mday(6)}
      ARMY_DAY = Clockwork{|x| c.may & c.mday(6)}
      EDUCATION_AND_CULTURE_DAY = Clockwork{|x| c.may & c.mday(24)}
      DAY_OF_THE_SLAVIC_HERITAGE = Clockwork{|x| c.may & c.mday(24)}
      DAY_OF_THE_UNION_OF_EASTERN_RUMELIA_WITH_THE_BULGARIAN_PRINCIPALITY = Clockwork{|x| c.september & c.mday(6)}
      INDEPENDENCE_DAY = Clockwork{|x| c.september & c.mday(22)}
      CHRISTMAS_EVE = Clockwork{|x| c.december & c.mday(24)}
      CHRISTMAS_DAY = Clockwork{|x| c.december & c.mday(25)}
      SECOND_DAY_OF_CHRISTMAS = Clockwork{|x| c.december & c.mday(26)}

    end
  end

end
