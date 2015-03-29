require 'minitest/autorun'
require_relative '../../lib/djikstra/graph/node'
require_relative '../../lib/djikstra/graph'

LABEL = 'T'

describe "Graph", "test my graph class" do
  before do
    @graph = Djikstra::Graph.new
  end
  
  it "can add a node and get the node" do
    @graph.add_node(LABEL)
    @graph.get_node(LABEL).must_be_instance_of(Djikstra::Node)
  end
  
  it "can add a node and remove a node" do
    @graph.add_node(LABEL)
    node = @graph.get_node(LABEL)
    node.label.must_equal(LABEL)
    
    @graph.remove_node(LABEL)
    @graph.get_node(LABEL).must_equal(nil)
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
    @graph.file_to_graph('../graph1.txt')
    nodes = @graph.get_nodes
    nodes.keys.must_equal( ['A', 'B', 'C', 'D', 'E', 'F', 'G'] )
  end
  
  it "can find the shortest path in a file" do
    @graph.file_to_graph('../graph1.txt')
    path_data = @graph.find_shortest_path('A', 'G')
    path_data['path'].must_equal('A,B,E,G')
    path_data['cost'].must_equal(6)
    
    @graph.file_to_graph('../graph2.txt')
    path_data = @graph.find_shortest_path('SY', 'PE')
    path_data['path'].must_equal('SY,CB,ME,AD,PE')
    path_data['cost'].must_equal(50)    
  end
end
