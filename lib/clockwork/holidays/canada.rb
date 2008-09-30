require "clockwork" unless defined? Clockwork

module Clockwork
  module Holidays
    module Canada


      NEW_YEARS_DAY = Clockwork{|x| c.january & c.mday(1)}
      #Good Friday
      #Easter Monday - Schools, Banks, and Government
      #VICTORIA_DAY = Clockwork{|x| c.first monday on or before may & c.mday(24)}
      CANADA_DAY = Clockwork{|x| c.july & c.mday(1)}
      #First Monday in September - Labour Day
      #Second Monday in October - Thanksgiving Day
      REMEMBRANCE_DAY = Clockwork{|x| c.november & c.mday(11)} #__LIMITED_TO_GOVERNMENT_AGENCIES
      CHRISTMAS_DAY = Clockwork{|x| c.december & c.mday(25)}
      BOXING_DAY = Clockwork{|x| c.december & c.mday(26)}

    end
  end

end
