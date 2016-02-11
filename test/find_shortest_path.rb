require_relative '../lib/dijkstra/graph/node'
require_relative '../lib/dijkstra/graph'

files = ['graph1.txt', 'graph2.txt', 'graph1.txt']
paths = [ ['A', 'G'], ['SY', 'PE'], ['A', 'Z'] ]

i = 0
files.each do |file|
  test = Dijkstra::Graph.new
  
  test.file_to_graph(file)
  
  2.times do |j|
    puts "path searching attempt #{j + 1}"
    path_data = test.find_shortest_path( *paths[i] )
    puts "  #{ path_data['path'] }, cost: #{ path_data['cost'] }" if path_data
  end
  
  i += 1
  puts ""
end
