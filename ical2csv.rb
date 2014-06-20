#!/usr/bin/env ruby

require 'icalendar'
require 'csv'
require 'active_support'
require 'time'

def sanitize(arg)
  arg.blank? ? '' : arg
end

def split_time(s)
  if s.nil?
    return ['', '', '', '', '', '', '', '', '']
  else
    time = Time.parse(s)
    return [
      time.year, time.month, time.day, time.wday, time.yday, time.hour,
      time.min, time.sec, time.zone]
  end
end

if ARGV.size < 2
  puts 'Usage: ical2csv infile.ics outfile.csv'
  abort
end

fields = [
  'created.year', 'created.month', 'created.day', 'created.wday',
  'created.yday', 'created.hour', 'created.min', 'created.sec', 'created.zone',
  'custom_components', 'custom_properties',  'description',  'dtend.year',
  'dtend.month', 'dtend.day', 'dtend.wday', 'dtend.yday', 'dtend.hour',
  'dtend.min', 'dtend.sec', 'dtend.zone',  'dtstamp.year', 'dtstamp.month',
  'dtstamp.day', 'dtstamp.wday', 'dtstamp.yday', 'dtstamp.hour', 'dtstamp.min',
  'dtstamp.sec', 'dtstamp.zone', 'dtstart.year', 'dtstart.month', 'dtstart.day',
  'dtstart.wday', 'dtstart.yday', 'dtstart.hour', 'dtstart.min', 'dtstart.sec',
  'dtstart.zone',  'ical_name', 'last_modified',  'location',  'name',
  'sequence',  'status', 'summary',  'transp',  'uid']

File.open(ARGV[0]) do |cal_file|
  CSV.open(ARGV[1], 'w') do |csv_file|

    # Parser returns an array of calendars because a single file
    # can have multiple calendars.
    cals = Icalendar.parse(cal_file)
    cal = cals.first
    csv_file << fields

    cal.events.each do |event|
      row = [
        split_time(sanitize(event.created.to_s)),
        sanitize(event.custom_components).to_s,
        sanitize(event.custom_properties).to_s,
        sanitize(event.description).to_s,
        split_time(sanitize(event.dtend.to_s)),
        split_time(sanitize(event.dtstamp.to_s)),
        split_time(sanitize(event.dtstart.to_s)),
        sanitize(event.ical_name),
        split_time(sanitize(event.last_modified.to_s)),
        sanitize(event.location),
        sanitize(event.name),
        sanitize(event.sequence),
        sanitize(event.status),
        sanitize(event.summary),
        sanitize(event.transp),
        sanitize(event.uid)
      ].flatten
      csv_file << row
    end
  end
end
