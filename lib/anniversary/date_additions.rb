require 'date'

class Date
  def in_year_with_correction(yr,mth=month)
    Date.civil_with_missing_day_correction(yr, mth, day)
  end
  alias_method :in_year_and_month_with_correction, :in_year_with_correction

  def self.civil_with_missing_day_correction(year, month, day)
    days_in_month = [
      #   J   F   M   A   M   J   J   A   S   O   N   D
      0, 31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31
      ][month]
      days_in_month = 29 if (month == 2) && ((year % 4 == 0) && ((year % 400 == 0) || (year % 100 != 0)))
      if (days_in_month < day)
        month += 1
        day = day - days_in_month
      end
      civil(year, month, day)
    end

    def years_months_days_since(date, debug = false)
      if date < self
        puts "#{self}.years_months_days_since(#{date})" if debug
        anniversary_this_year = date.in_year_with_correction(year)
        puts "anniversary_this_year is #{anniversary_this_year}" if debug
        years = if anniversary_this_year <= self
          year - date.year
        else
          year - date.year - 1
        end
        last_monthiversary = monthiversary_this_month = date.in_year_and_month_with_correction(year, month)
        puts "monthiversary_this_month is #{monthiversary_this_month}" if debug
        if (monthiversary_this_month > self)
          last_month = Date.civil(year, month, 1) << 1
          last_monthiversary = date.in_year_and_month_with_correction(last_month.year, last_month.month)
        end
        puts "last_monthiversary is #{last_monthiversary}" if debug

        if last_monthiversary > date
          months = (last_monthiversary.month - anniversary_this_year.month)
          months += 12 if months < 0
        else
          months = 0
        end
        days = (self - last_monthiversary).to_i
      elsif date > self
        date.years_months_days_since(self, debug).map {|v| -v}
      else
        years, months, days = 0, 0, 0
      end

      [years, months, days]
    end
  end