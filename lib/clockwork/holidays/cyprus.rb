require "clockwork" unless defined? Clockwork

module Clockwork
  module Holidays
    module Cyprus

      NEW_YEARS_DAY = Clockwork{|x| c.january & c.mday(1)}
      #Good Friday, Easter Sunday and Easter Monday - variable dates
      GREEK_INDEPENDENCE_DAY = Clockwork{|x| c.march & c.mday(25)}
      CYPRUS_NATIONAL_DAY = Clockwork{|x| c.april & c.mday(1)}
      LABOUR_DAY = Clockwork{|x| c.may & c.mday(1)}
      ASSUMPTION_OF_MARY = Clockwork{|x| c.august & c.mday(15)}
      CYPRUS_INDEPENDENCE_DAY = Clockwork{|x| c.october & c.mday(1)}
      CHRISTMAS_DAY = Clockwork{|x| c.december & c.mday(25)}
      BOXING_DAY = Clockwork{|x| c.december & c.mday(26)}

    end
  end

end
