require 'minitest/autorun'
require_relative '../../lib/dijkstra/graph/node'
require_relative '../../lib/dijkstra/graph'

GRAPH_NODE = 'T'

describe "Graph", "test my graph class" do
  before do
    @graph = Dijkstra::Graph.new
  end

  it "can add a node and get the node" do
    @graph.add_node(GRAPH_NODE)
    @graph.get_node(GRAPH_NODE).must_be_instance_of(Dijkstra::Node)
  end

  it "can add a node and remove a node" do
    @graph.add_node(GRAPH_NODE)
    node = @graph.get_node(GRAPH_NODE)
    node.label.must_equal(GRAPH_NODE)

    @graph.remove_node(GRAPH_NODE)
    @graph.get_node(GRAPH_NODE).must_equal(nil)
  end

  it "can add nodes and remove them all in one fell swoop" do
    @graph.add_node('B')
    @graph.add_node('Y')
    @graph.add_node('E')

    nodes = @graph.get_nodes
    nodes.keys.must_equal( ['B', 'Y', 'E'] )

    @graph.remove_nodes()
    @graph.get_nodes().must_equal( {} )
  end

  it "can add an edge and return new nodes" do
    node_list = ['T', 'U']
    @graph.add_edge(*node_list, 1)

    node_list.each do |n|
      node = @graph.get_node(n)
      node.label.must_equal(n)
    end
  end

  it "can import a file into a graph" do
    @graph.file_to_graph( File.join(File.dirname(__FILE__), '../graph1.txt') )
    nodes = @graph.get_nodes
    nodes.keys.must_equal( ['A', 'B', 'C', 'D', 'E', 'F', 'G'] )
  end

  it "can find the shortest path in a file" do
    @graph.file_to_graph( File.join(File.dirname(__FILE__), '../graph1.txt') )
    path_data = @graph.find_shortest_path('A', 'G')
    path_data['path'].must_equal('A,B,E,G')
    path_data['cost'].must_equal(6)

    @graph.file_to_graph( File.join(File.dirname(__FILE__), '../graph2.txt') )
    path_data = @graph.find_shortest_path('SY', 'PE')
    path_data['path'].must_equal('SY,CB,ME,AD,PE')
    path_data['cost'].must_equal(50)
  end
end
