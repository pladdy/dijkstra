require_relative '../lib/dijkstra/graph/node'
require_relative '../lib/dijkstra/graph'

test = Dijkstra::Graph.new

test.file_to_graph('graph1.txt')

puts test.get_nodes
