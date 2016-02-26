require 'json'

# noinspection RubyResolve
data = JSON.load(File.read('export.json'))

puts "Loading #{data.size} records."

data.each do |record|
  poi = Poi.new
  poi.metadata = record
  poi.name = record['title']
  poi.preview = record['edmPreview'] unless record['previewNoDistribute']
  geodata = record['lbsLatLon']
  next if geodata.empty?
  geokey = geodata.keys.sort_by(&:length)[-1]
  poi.location = geodata[geokey]
  poi.save
  print '.'
  $stdout.flush
end

Poi.create_indexes
