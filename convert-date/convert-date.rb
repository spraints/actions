#!/usr/bin/env ruby

require "json"
require "octokit"
require "time"
require "tzinfo"

event = JSON.load(File.read(ENV["GITHUB_EVENT_PATH"]))
comment = event.fetch("comment").fetch("body")
comments_url = event.fetch("issue").fetch("comments_url")

list_zones = false
time_parts = {source_zone: [], dest_zone: []}
zone_key = :source_zone

comment.split(/\s+/).each do |word|
  case word
  when "in"
    zone_key = :dest_zone
  when "list", "zones"
    list_zones = true
  else
    if word =~ /(\d\d\d\d)-(\d\d)-(\d\d)/
      time_parts[:year]   = $1.to_i
      time_parts[:month]  = $2.to_i
      time_parts[:day]    = $3.to_i
    end
    if word =~ /(\d\d):(\d\d)/
      time_parts[:hour]   = $1.to_i
      time_parts[:minute] = $2.to_i
    end
    begin
      time_parts[zone_key] << TZInfo::Timezone.get(word)
    rescue => e
      puts "#{e.class}: #{e}"
    end
  end
end

output = ""

if list_zones
  output << "ZONES\n=====\n#{TZInfo::Timezone.all_identifiers.join("\n")}\n\n"
end

time_parts[:source_zone].each do |source_zone|
  now = source_zone.to_local(Time.now)
  year    = time_parts.fetch(:year,   now.year)
  month   = time_parts.fetch(:month,  now.month)
  day     = time_parts.fetch(:day,    now.day)
  hour    = time_parts.fetch(:hour,   now.hour)
  minute  = time_parts.fetch(:minute, now.min)

  source_time = source_zone.local_time(year, month, day, hour, minute, 0)

  time_parts[:dest_zone].each do |dest_zone|
    dest_time = dest_zone.to_local(source_time)
    output << "#{source_time} => #{dest_time}\n"
  end
end

if output == ""
  puts "Nothing to say!"
else
  client = Octokit::Client.new(access_token: ENV["GITHUB_TOKEN"])
  client.post comments_url, body: output
end
