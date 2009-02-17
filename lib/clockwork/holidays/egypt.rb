require "clockwork" unless defined? Clockwork

module Clockwork

  module Holidays
    module Egypt


      COPTIC_CHRISTMAS_DAY = Clockwork{|c| c.january & c.mday(7)}
      DAY_OF_SINAI_LIBERATION = Clockwork{|c| c.april & c.mday(25)} # _OBSERVED_IN_THE_SINAI_ONLY
      LABOUR_DAY = Clockwork{|c| c.may & c.mday(1)}
      EVACUATION_DAY = Clockwork{|c| c.june & c.mday(18)}
      REVOLUTION_DAY = Clockwork{|c| c.july & c.mday(23)}
      FLOODING_OF_THE_NILE = Clockwork{|c| c.august & c.mday(15)}
      ARMED_FORCES_DAY = Clockwork{|c| c.october & c.mday(6)}
      SUEZ_VICTORY_DAY = Clockwork{|c| c.october & c.mday(24)}
      VICTORY_DAY = Clockwork{|c| c.december & c.mday(23)}
      #Eid ul-Adha - variable date (celebrated by muslims)
      #Eid ul-Fitr - variable date (celebrated by muslims)
      #Easter Sunday and Easter Monday - variable date
      #Islamic New Year - variable date

      #In addition, the following holidays are reserved for observance by Copts, though are not national holidays:

      COPTIC_NEW_YEARS_DAY = Clockwork{|c| c.september & c.mday(11)}
      extend HolidayMixin

    end
  end

end
