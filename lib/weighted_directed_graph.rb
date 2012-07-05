class WeightedDirectedGraph
  
  def initialize
    @nodes = {}
  end
  
  def add_node(name)
    @nodes[name] ||= {} 
  end
  
  def connect(a,b,weight=1)
    raise InvalidArgument unless contains?(a) and contains?(b)
    @nodes[a][b] = weight
  end
  
  def edge_weight(a,b)
    @nodes[a][b] || 0
  end
  
  def contains?(name)
    @nodes.has_key?(name)
  end
  
  def out_degree_of(name)
    destinations(name).values.inject {|a, b| a + b} || 0
  end

  def nodes
    @nodes.keys
  end  
  
  def destinations(name)
    @nodes[name]
  end
end