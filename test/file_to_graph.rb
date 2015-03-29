require_relative '../lib/djikstra/graph/node'
require_relative '../lib/djikstra/graph'

test = Djikstra::Graph.new

test.file_to_graph('graph1.txt')

puts test.get_nodes
