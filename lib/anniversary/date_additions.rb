require 'date'

class Date
  # Return the equivalent date in a different year and optionally month.
  # If the result of just changing the year and or month results in an invalid date
  # e.g. September 31 in any year, or February 29 in a non-leap year, then return a valid
  # date in the next month, see Date.civil_with_missing_day_correction
  def in_year_with_correction(yr,mth=month)
    Date.civil_with_missing_day_correction(yr, mth, day)
  end
  alias_method :in_year_and_month_with_correction, :in_year_with_correction

  # Return a date with a given year, month and day.  If the date would be invalid because that day does 
  # not exist in that month in that year, then return an equivalent date, 'reflected' around the end of the month.
  # For example, Date.civil_with_missing_day_correction(2001, 2, 29) would return Date.civil(2001, 3, 1), and
  # Date.civil_with_missing_day_correction(2011, 2, 31) would return Date.civil(2011, 3, 2)
  def self.civil_with_missing_day_correction(year, month, day)
    days_in_month = [
      #   J   F   M   A   M   J   J   A   S   O   N   D
      0, 31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31
      ][month]
      days_in_month = 29 if (month == 2) && ((year % 4 == 0) && ((year % 400 == 0) || (year % 100 != 0)))
      if (days_in_month < day)
        month += 1
        day = 1
      end
      civil(year, month, day)
    end

    # return a 3 element array comprising the number of years, months and days which have occurred between the argument
    # initial_date and the receiver
    #
    # :call-seq:
    # years_months_days_since(initial_date)
    #
    # The return values are
    #    0. years - the number of anniversary dates which have occurred 
    #    1. months - the number of 'monthiversary' dates which have occurred since the last anniversary date
    #    2. days - the number of days since the last monthiversary
    #
    # If the receiver is before the argument then years, months and days will be 0 or negative values.
    def years_months_days_since(initial_date, debug = false)
      if initial_date < self
        puts "#{self}.years_months_days_since(#{initial_date})" if debug
        anniversary_this_year = initial_date.in_year_with_correction(year)
        puts "anniversary_this_year is #{anniversary_this_year}" if debug
        years = if anniversary_this_year <= self
          year - initial_date.year
        else
          year - initial_date.year - 1
        end
        last_monthiversary = initial_date.in_year_and_month_with_correction(year, month)
        puts "last_monthiversary is #{last_monthiversary}" if debug
        if (last_monthiversary > self)
          last_month = Date.civil(year, month, 1) << 1
          while (last_monthiversary > self)
            last_monthiversary = initial_date.in_year_and_month_with_correction(last_month.year, last_month.month)
            last_month = last_month << 1
          end
        end
        puts "last_monthiversary after correction is #{last_monthiversary}" if debug

        if last_monthiversary > initial_date
          months = (last_monthiversary.month - anniversary_this_year.month)
          months -= 1 unless last_monthiversary.day == initial_date.day
          months += 12 if months < 0
        else
          months = 0
        end
        days = (self - last_monthiversary).to_i
      elsif initial_date > self
        initial_date.years_months_days_since(self, debug).map {|v| -v}
      else
        years, months, days = 0, 0, 0
      end

      [years, months, days]
    end
    
    # return a 3 element array comprising the number of years, months and days which will occur between the argument
    # end_date and the receiver
    #
    # :call-seq:
    # years_months_days_until(end_date)
    #
    # The return values are
    #    0. years - the number of anniversary dates which will occur 
    #    1. months - the number of 'monthiversary' dates which will occur after the last anniversary date
    #    2. days - the number of days after the last monthiversary
    #
    # If the receiver is after the argument then years, months and days will be 0 or negative values.
    def years_months_days_until(end_date, debug = false)
      end_date.years_months_days_since(self)
    end
  end