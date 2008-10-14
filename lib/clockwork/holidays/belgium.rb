require "clockwork" unless defined? Clockwork

module Clockwork
  module Holidays
    module Belgium

      NEW_YEARS_DAY = Clockwork{|c| c.january & c.mday(1)}
      #Good Friday, Easter Sunday and Easter Monday - variable dates
      LABOUR_DAY = Clockwork{|c| c.may & c.mday(1)}
      #Ascension day - (variable date)
      #Whit Sunday or Pentecost - (variable date)
      #Whit Monday or Pentecost Monday - (variable date)
      FLEMISH_COMMUNITY_HOLIDAY = Clockwork{|c| c.july & c.mday(11)} #_ONLY_HELD_IN_FLANDERS__NOT_A_PUBLIC_HOLIDAY
      NATIONAL_HOLIDAY = Clockwork{|c| c.july & c.mday(21)}
      ASSUMPTION_OF_MARY = Clockwork{|c| c.august & c.mday(15)}
      FRENCH_COMMUNITY_HOLIDAY = Clockwork{|c| c.september & c.mday(27)} # _ONLY_HELD_IN_WALLONIA__NOT_A_PUBLIC_HOLIDAY
      ALL_SAINTS = Clockwork{|c| c.november & c.mday(1)}
      ALL_SOULS_DAY = Clockwork{|c| c.november & c.mday(2)} # _NOT_A_PUBLIC_HOLIDAY_MOST_COMPANIES_ARE_CLOSED
      ARMISTICE_DAY = Clockwork{|c| c.november & c.mday(11)}
      DYNASTY_DAY = Clockwork{|c| c.november & c.mday(15)} #__DAY_OF_GERMANSPEAKING_COMMUNITY_ONLY_HELD_IN_AREAS_OF_THE_GERMANSPEAKING_COMMUNITY_OF_BELGIUM
      CHRISTMAS_DAY = Clockwork{|c| c.december & c.mday(25)}

    end
  end

end
