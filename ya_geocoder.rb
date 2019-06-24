require './lib/ya_geocoder/requester'
require './lib/ya_geocoder/geojsonbuilder'
require './lib/ya_geocoder/config'

require 'simple_xlsx'
require 'httparty'
require 'json'
require 'rgeo/geo_json'
require 'byebug'

count = 0
exeptions = []

arr_of_lines_1 = File.open(DATAFILE_1) { |i| i.readlines }
arr_of_lines_1.map! { |i| i.chomp.split.join(' ') + " Минск" }

arr_with_resp_1 = arr_of_lines_1.map do |i|
count += 1
puts "Coding line: #{count}: #{i}"
coordinates = Requester.send i, exeptions
    begin
        coordinates.split + ["#87ceeb", i]
    rescue
        puts "---------------------------------------------Caught error with #{i}"
        next
    end
end

arr_of_lines_2 = File.open(DATAFILE_2) { |i| i.readlines }
arr_of_lines_2.map! { |i| i.chomp.split.join(' ') + " Минск" }

arr_with_resp_2 = arr_of_lines_2.map do |i|
count += 1
puts "Coding line: #{count}: #{i}"
coordinates = Requester.send i, exeptions
    begin
    coordinates.split + ["#ffef00", i]
    rescue
        puts "---------------------------------------------Caught error with #{i}"
        next
    end
end

arr_of_lines_3 = File.open(DATAFILE_3) { |i| i.readlines }
arr_of_lines_3.map! { |i| i.chomp.split.join(' ') + " Минск" }



arr_with_resp_3 = arr_of_lines_3.map do |i|
count += 1
puts "Coding line: #{count}: #{i}"
coordinates = Requester.send i, exeptions
    begin
    coordinates.split + ["#e6000d", i]
    rescue
        puts "---------------------------------------------Caught error with #{i}"
        next
    end
end

arr_with_resp = arr_with_resp_1 + arr_with_resp_2 + arr_with_resp_3

puts "Parsed #{arr_with_resp.count} adresses"

arr_with_resp.reject! { |i| i == nil }

json = GeoJSONBuilder.build_geojson arr_with_resp

f = File.new('out.geojson', 'w')
f.write(json.to_json)
f.close

e = File.new('exeptions.txt', 'w')
e.write(exeptions.join("\n"))
e.close