module Clockwork
  module Holidays
    class << self
      def all_regions
       @all_regions ||= constants.map { |x| const_get(x) }
      end

      def holiday?(date, region = nil)
       search_regions = region ? Array(region) : all_regions
       search_regions.any? { |r| r.has_holiday?(date) }
      end

      alias_method :include?, :holiday?
      alias_method :===,      :holiday?
    end

  end

  module HolidayMixin
    def all_holidays
      @all_holidays ||= constants.map { |x| const_get(x) }
    end
    # has_a_holiday?
    # accepts a date
    # creates an array of holidays for the module
    # checks to see if the date is in the array
    def has_holiday?(date)
      all_holidays.any? { |h| h === date }
    end

    alias_method :include?, :has_holiday?
    alias_method :===,      :has_holiday?
  end

end

Dir[File.dirname(__FILE__) + "/holidays/**/*.rb"].each { |lib| require lib }
