class TSPSolver
    def initialize(adj_matrix)
      @adj_matrix = adj_matrix.map do |row|
        row.map { |cost| cost == 0 ? Float::INFINITY : cost }
      end
      @num_nodes = adj_matrix.length
    end
  
    def solve
      @min_path_cost = Float::INFINITY
      @best_path = nil
      starting_node = 0
      visited = [false] * @num_nodes
      visited[starting_node] = true
      path = [starting_node]
  
      tsp_helper(starting_node, visited, path, 0)
  
      { cost: @min_path_cost, path: @best_path }
    end
  
    private
  
    def tsp_helper(current_node, visited, path, current_cost)
      if path.length == @num_nodes
        current_cost += @adj_matrix[current_node][path[0]]
        if current_cost < @min_path_cost
          @min_path_cost = current_cost
          @best_path = path + [path[0]]
        end
        return
      end
  
      (0...@num_nodes).each do |next_node|
        if !visited[next_node]
          visited[next_node] = true
          path.push(next_node)
          tsp_helper(next_node, visited, path, current_cost + @adj_matrix[current_node][next_node])
          path.pop
          visited[next_node] = false
        end
      end
    end
  end
  
  adj_matrix = [
    [Float::INFINITY, 20, 30, 10, 11],
    [15, Float::INFINITY, 16, 4, 2],
    [3, 5, Float::INFINITY, 2, 4],
    [19, 6, 18, Float::INFINITY, 3],
    [16, 4, 7, 16, Float::INFINITY]
  ]
  
  solver = TSPSolver.new(adj_matrix)
  result = solver.solve
  puts "Minimum cost: #{result[:cost]}"
  puts "Best path: #{result[:path].inspect}"
  