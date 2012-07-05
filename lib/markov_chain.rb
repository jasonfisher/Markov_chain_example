require File.dirname(__FILE__) + '/weighted_directed_graph'

class MarkovChain
  attr_accessor :graph
  
  def initialize
    @graph = WeightedDirectedGraph.new
  end
  
  def increment_probability(a,b)
    @graph.add_node(a) if ! @graph.contains?(a)
    @graph.add_node(b) if ! @graph.contains?(b)
    weight = @graph.edge_weight(a, b)
    @graph.connect(a, b, weight + 1)
  end

  def random_walk(start = random_node)
    destinations = @graph.destinations(start)
    retval = [start]
    while (sum = node_sum(retval.last)) > 0 do
      winner = rand(sum)
      step = 0
      @graph.destinations(retval.last).each do |dest|
        dest_node = dest[0]
        dest_weight = dest[1]
        step += dest_weight
        if winner < step
          retval << dest_node
          break
        end              
      end
    end
    
    retval
  end
  
private 
  def random_node
    @graph.nodes[rand(@graph.nodes.size)]    
  end

  def node_sum(node)
    @graph.destinations(node).values.inject {|a, b| a + b} || 0
  end

end