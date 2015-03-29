require_relative '../lib/djikstra/graph/node'
require_relative '../lib/djikstra/graph'

test = Djikstra::Graph.new

puts "adding and removing node"
test.add_node('A')

puts "nodes: ", test.get_nodes, "\n"

test.remove_node('A')
test.remove_node('A')

puts "nodes: ", test.get_nodes, "\n"

puts "adding edge"
test.add_edge('A', 'Z', 26)

puts "nodes: ", test.get_nodes, "\n"
puts "edges: ", test.get_edges, "\n"

puts "removing node from graph"
test.remove_node('Z')

puts "nodes: ", test.get_nodes, "\n"
puts "edges: ", test.get_edges, "\n"
