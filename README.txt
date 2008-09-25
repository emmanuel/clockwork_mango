= clockwork

* http://clockwork.rubyforge.org

== DESCRIPTION:

Clockwork provides an implementation of Temporal Expressions, as described 
(roughly) by Martin Fowler in his paper "Recurring Events for Calendars" 
(http://martinfowler.com/apsupp/recurring.pdf).

== FEATURES/PROBLEMS:

* Describe event recurrence with a simple DSL.
* Simple, clean, well-specified codebase.
* Unified implementation for Precisioned Dates, Date and Time Ranges,
  and recurrence.

== SYNOPSIS:

The main interface is the Clockwork.schedule method, which accepts a block 
that defines the returned Clockwork::Expression object. The most basic 
Expression matches on a single attribute (an Assertion). Assertion builder 
methods are named after the attribute they assert, and accept integers or 
ranges.

  mondays = Clockwork.schedule { wday(1) }
  weekdays = Clockwork.schedule { wday(1..5) }
  nine_to_five = Clockwork.schedule { hour(9..17) }
  this_year = Clockwork.schedule { year(Time.now.year) }

Single value assertions and ranges are not terribly useful on their own, so 
they can be composed into (arbitrarily complex) expressions using the set 
operations #&, #|, and #-.

  now = Time.now
  yesterday = Clockwork.schedule do
    year(now.year) & month(now.month) & mday(now.mday - 1)
  end
  work_time = Clockwork.schedule { hour(9..17) & wday(1..5) }
  weekend = Clockwork.schedule { wday(0) | wday(6) }

Named shortcuts for weekdays and months are provided (in both singular and 
plural forms).

  mon_wed_fri = Clockwork.schedule { mondays | wednesdays | fridays }
  christmas = Clockwork.schedule { december & mday(25) }

Some additional methods are available to deal with particular types of dates: 
#mweek (week of the month), #wday_ordinal (ordinal occurrence of 
weekday in month, eg. Thanksgiving in the US: the 3rd thursday of November).

  art_walk = Clockwork.schedule { thursday & wday_ordinal(1) }
  thanksgiving = Clockwork.schedule { november & thursday & wday_ordinal(3) }

Times of day and time ranges can be specified with the #at and #from methods, which 
accept hours, minutes and optionally seconds as integers in 24 hour format:

  work_week = Clockwork.schedule { from(915..1745) & wday(1..5) }
  back_to_work = Clockwork.schedule { at(915) & mondays }

As mentioned, expressions can be composed as needed, but be aware of 
precedence when building complex expressions:

  class_time = Clockwork.schedule do
    ((mondays | wednesdays | thursdays) & from(1900..2130)) |
      (sundays & from(1200..1330))
  end

So, what do you do with these objects? Clockwork::Expression objects provide 
a #=== method to test inclusion of a Date, Time, DateTime, or other similar 
object. Any object that quacks like a Time object can be tested: attributes 
#year, #month, #mday, #hour, #min, #sec, as well as #wday, #yday (ordinal day 
of the year), #yweek (ordinal week of the year) and the previously mentioned 
attributes can be tested for.

  loop do
    case Time.now
    when class_time
      # do something appropriate
    end

    sleep 15.minutes
  end

== REQUIREMENTS:

* FIX (list of requirements)

== INSTALL:

* sudo gem install clockwork

== LICENSE:

(The MIT License)

Copyright (c) 2008 Emmanuel Gomez

Permission is hereby granted, free of charge, to any person obtaining
a copy of this software and associated documentation files (the
'Software'), to deal in the Software without restriction, including
without limitation the rights to use, copy, modify, merge, publish,
distribute, sublicense, and/or sell copies of the Software, and to
permit persons to whom the Software is furnished to do so, subject to
the following conditions:

The above copyright notice and this permission notice shall be
included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED 'AS IS', WITHOUT WARRANTY OF ANY KIND,
EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.
IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY
CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT,
TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE
SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
