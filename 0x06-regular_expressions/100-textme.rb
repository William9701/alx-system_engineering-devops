#!/usr/bin/env ruby

def extract_data(input)
  matches = input.scan(/\[(?:from|to):([\w\d\s+]+)\]|\[flags:([\w\s:-]+)\]/i).flatten.compact
    matches.each_slice(3).map { |match| match.compact.join(",") }
end

input = ARGV[0]

data = extract_data(input)

if data.empty?
  puts "no match found"
else
  puts data.join("")
end
