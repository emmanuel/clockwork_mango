module Clockwork
  module Holidays

    def self.holiday?(date,region = nil)
      regions = []
      if region
        regions = region.to_a
      else
        @@regions_cache ||= constants.map{|x| const_get(x) }
        regions = @@regions_cache
      end
      regions.any?{|r| r.has_holiday?(date) }
    end

    def self.include?(date)
      holiday?(date)
    end
  end

  module HolidayMixin
    # has_a_holiday?
    # accepts a date
    # creates an array of holidays for the module
    # checks to see if the date is in the array
    def has_holiday?(date)
      all_holidays = constants.map{|x| const_get(x)}
      all_holidays.any?{|h| h === date}
    end

    def include?(date)
      has_holiday?(date)
    end

    def ===(date)
      has_holiday?(date)
    end
  end

end

Dir[File.dirname(__FILE__) + "/holidays/**/*.rb"].each { |lib| require lib }
