# README

API Sunrise-Sunset courtesy of https://sunrise-sunset.org/api


To retrieve API information, run from the command line:

SunriseSunsetJob.new.perform(lat, long, date) where lat is a valid latitude, long is a valid longitude, and date is a valid date in format 'YYYY-MM-DD'.

You will receive information on the sunrise & sunset times for that particular date.

If you do not enter a date, the default is today's date. All times are in UTC time.

If this is a new search, the search will be saved to the db.