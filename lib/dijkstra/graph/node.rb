###
# Dijkstra::Node
#
# The node class handles creating node objects that belong to graphs.  Nodes
# are automatically created in the graph class.  Since nodes can't be
# created separately and added to a graph use the api provided in the graph.
#
###

module Dijkstra
  class Node
    attr_reader :label

    # path variables
    attr_reader :visited_default, :distance_default
    attr_accessor :visited, :distance

    def initialize(label)
      @label = label
      @neighbors = Hash.new()

      # path finding properties
      @visited_default = @visisted = false
      @distance_default = @distance = nil
    end

    ##
    # given a label and optional weight this assigns a neighboring node
    def add_neighbor(label, weight = 0)
      @neighbors[label] = weight
    end

    ##
    # remove a neighbor from the node designated by the label
    def remove_neighbor(label)
      @neighbors.delete(label)
    end

    ##
    # return the neighbors weight given a neighbor/node label
    def get_neighbor_weight(label)
      @neighbors[label]
    end

    ##
    # return all neighbors for the node
    def get_neighbors()
      @neighbors
    end
  end
end
