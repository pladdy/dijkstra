###
# Dijkstra::Graph
#
# This class creates a graph data structure that can be built from a file
# with a list of edges or even one node at a time using the provided API.
#
# Synopsis:
#   graph = Dijkstra::Graph.new
#
#   graph.add_node('A')
#
#   graph.add_edge('A', 'B', 3)
#     Adding edges will automatically add nodes if the nodes don't exist in
#     the graph already.
#
#   graph.file_to_graph('your file of edges')
#     Removes existing edges and nodes and rebuilds the graph from a file
#
#     File must be a list of edges in array notation.
#     Example:
#       [A,B,1]
#       [A,C,3]
#       [B,C,2]
#       [B,D,1]
#
#    Above file would create a graph with 4 nodes (A, B, C, D)
#
#  graph.find_shortest_path('A', 'D')
#    Returns a hash with results about the shortest path.  Using the above file
#    the 'path' property would be A,B,D and the 'cost' property would be 2.
#
# ---
###

module Dijkstra
  class Graph
    def initialize
      @nodes = Hash.new()
      @edges = Array.new()
    end

    ##
    # Node API: accessors on the nodes hash make it possible to add keys
    # manually in a script breaking encapsulation
    ##

    ##
    # creates a new Dijkstra::Node object and stores in a hash with the label
    # as the key
    def add_node(label)
      @nodes[label] = Node.new(label)
    end

    ##
    # return a Dijkstra::Node given a label
    def get_node(label)
      @nodes[label]
    end

    ##
    # return all nodes in graph (hash)
    def get_nodes()
      @nodes
    end

    ##
    # delete a node given a label; consequently it also
    #   deletes this node from any neighbor list in the graph
    #   deletes any edges using the node
    def remove_node(label)
      @nodes.delete(label)

      ## find any nodes with label as a neighbor and remove ##
      @nodes.each do |node_label, node|
        node.remove_neighbor(label)
      end

      ## go through edges and remove any edge involving removed node ##
      e = 0
      @edges.each do |edge|
        @edges.delete_at(e) if edge[0].eql?(label) or edge[1].eql?(label)
        e += 1
      end
    end

    ##
    # deletes all nodes and edges from graph
    def remove_nodes()
      @nodes = Hash.new()
      @edges = Array.new()
    end

    ##
    # adds an edge to the graph as well as node(s) if nodes don't exist
    def add_edge(start_node, end_node, weight)
      # make sure nodes exist before storing edge
      [start_node, end_node].each do |node|
        self.add_node(node) unless @nodes.has_key?(node)
      end

      # store edge
      @edges.push( [start_node, end_node, weight.to_i] )

      # add neighboring node to start node
      @nodes[start_node].add_neighbor(end_node, weight.to_i)
    end

    def get_edges()
      @edges
    end

    ##
    # given a file with a list of arrays, and each array a start, end, and
    # then a weight this will build a graph using the edges provided.
    #
    # example of file construction:
    # [A,B,1]
    # [A,C,2]
    # ...
    def file_to_graph(path)
      @nodes = Hash.new()
      @edges = Array.new()

      begin
        file = File.open(path)

        ## remove brackets on each line and pass data into add_edge ##
        file.each do |line|
          line.chomp!
          line.gsub!(/\[|\]/, '')
          (start_node, end_node, weight) = line.split(',')
          self.add_edge(start_node, end_node, weight.to_i)
        end

        file.close
      rescue Exception => e
        puts e.message
        puts "\nbacktrace:\n"
        puts e.backtrace.join("\n")
        exit
      end
    end

    ##
    # implements dijkstras algorithm (breadth first search) to find
    # the shortest point between two nodes within the graph.
    #
    # method will return a hash with two properties:
    #   path: path as a comma delimited string showing the path
    #   cost: total cost based on node weight for the path
    def find_shortest_path(start_node_label, end_node_label)
      # make sure nodes exist
      [start_node_label, end_node_label].each do |label|
        return if node_absent(label)
      end

      # reset nodes for path search and initialize start distance
      reset_nodes_path_properties()
      @nodes[start_node_label].distance = 0

      # initialize queue and path tracking variables
      queue = [start_node_label]
      path_cost = 0
      previous_node_labels = Hash.new() # track path to end node

      while !queue.empty? do
        node_label = queue.pop()
        break if node_label.eql?(end_node_label) # found the end node

        # get neighbors and sort them by min distance
        node = self.get_node(node_label)
        neighbors = node.get_neighbors().sort_by { |k,v| v.to_i }

        neighbors.each do |neighbor_label, neighbor_weight|
          neighbor = self.get_node(neighbor_label)
          next if neighbor.visited

          # add neighbor to queue and calculate potential distance
          queue.unshift(neighbor_label)
          path_cost = node.distance.to_i + neighbor_weight.to_i

          # if distnace is shorter, then update and add to previous nodes
          if neighbor.distance.nil? or path_cost < neighbor.distance
            neighbor.distance = path_cost
            previous_node_labels[neighbor_label] = node.label
          end
        end

        node.visited = true # so node isn't checked again
      end

      # after search, backtrack and build path
      path = backtrack_path(previous_node_labels, end_node_label)

      # if a path was found prepend the start node, else there's no path
      path_cost > 0 ? path.unshift(start_node_label) : path = ['non-existent']
      end_node = self.get_node(end_node_label)

      return {'path' => path.join(','), 'cost' => end_node.distance}
    end
    # ------------------------------------------------------------------------ #

    private

    ##
    # check for absent node and broadcast
    def node_absent(node_label)
      unless @nodes.has_key?(node_label)
        puts "node #{node_label} does not exist"
        return true
      end
    end

    ##
    # given a hash of node labels, trace the path created using the provided
    # end node and updating it each iteration to get to the start of the
    # path.
    def backtrack_path(previous_labels, previous_label)
      path = []
      while previous_labels.has_key?(previous_label) do
        path.unshift(previous_label)
        previous_label = previous_labels[previous_label]
      end

      return path
    end

    ##
    # go through each node and reset 'path' variables
    def reset_nodes_path_properties()
      self.get_nodes.each do |k, v|
        v.visited = v.visited_default
        v.distance = v.distance_default
      end
    end
    # ------------------------------------------------------------------------ #
  end # class
end # module
