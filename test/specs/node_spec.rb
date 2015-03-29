require 'minitest/autorun'
require_relative '../../lib/djikstra/graph/node'

LABEL = 'T'

describe 'Node', 'test node class' do
  before do
    @node = Djikstra::Node.new(LABEL)
  end
  
  # property tests
  it "has a label property" do
    @node.label.must_equal(LABEL)
  end
  
  it "can have distance set" do
    @node.distance = 1
    @node.distance = 0
  end
  
  it "can have visited boolean set" do
    @node.visited = true
  end
  
  # method tests
  it "has a neighbors list but should be empty" do
    @node.get_neighbors().must_equal( [] )
  end
  
  it "can add a neighbor and weight" do
    @node.add_neighbor('B', 3)
    @node.get_neighbor_weight('B').must_equal(3)    
  end
  
  it "can get a list of neighbors back after adding one" do
    @node.add_neighbor('B', 3)
    @node.get_neighbors.must_equal( [ ['B', 3] ] )    
  end
  
  it "can remove a neighbor" do
    @node.remove_neighbor('B')
    @node.get_neighbors().must_equal( [] )
  end
end
