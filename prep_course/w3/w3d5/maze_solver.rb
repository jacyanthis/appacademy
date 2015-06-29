require 'byebug'

class Maze

  def initialize(maze_file)
    @grid = load_maze(maze_file)
    @start = find_start
    @end = find_end
  end
  
  def [](row, col)
    @grid[row][col]
  end

  def []=(row, col, mark)
    @grid[row][col] = mark
  end

  def load_maze(maze_file)
    temp_grid = []
    File.foreach(maze_file) do |line|
      temp_grid << line.chomp.split("")
    end
    temp_grid
  end
  
  def find_start
    temp_start = nil
    @grid.each_with_index do |row, row_idx|
      row.each_with_index do |location, col_idx|
        if location == "S"
          if temp_start == nil 
            temp_start = [row_idx, col_idx] 
          else puts "two start points found! first start point used"
          end
        end
      end
    end
    temp_start
  end
  
  def find_end
    temp_end = nil
    @grid.each_with_index do |row, row_idx|
      row.each_with_index do |location, col_idx|
        if location == "E"
          if temp_end == nil 
            temp_end = [row_idx, col_idx] 
          else puts "two end points found! first end point used"
          end
        end
      end
    end
    temp_end   
  end
  
  def solve_maze
    solution = find_best_path(*@start, @grid, 0, [true, true, true, true], nil)[0]
    solution == "dead end" ? (puts "no solution") : display(solution)
  end
  
  def find_best_path(current_row, current_col, current_grid, steps, previous_adjacents, direction)
    if current_grid[current_row][current_col] == "E"
      return [current_grid, steps]
    else
      paths = {}
      up = current_grid[current_row - 1][current_col]
      left = current_grid[current_row][current_col - 1]
      right = current_grid[current_row][current_col + 1]
      down = current_grid[current_row + 1][current_col]
      adjacents = [up, left, right, down]
      interesting_directions = find_new_openings(previous_adjacents, adjacents, direction)
      if (up == " " || up == "E") && interesting_directions[0]
        up_grid = deep_dup(current_grid)
        up_grid[current_row][current_col] = "X" if current_grid[current_row][current_col] != "S"
        info = find_best_path(current_row - 1, current_col, up_grid, steps + 1, adjacents, "up")
        paths[info[0]] = info[1]
      end
      if (left == " " || left == "E") && interesting_directions[1]
        left_grid = deep_dup(current_grid)
        left_grid[current_row][current_col] = "X" if current_grid[current_row][current_col] != "S"
        info = find_best_path(current_row, current_col - 1, left_grid, steps + 1, adjacents, "left")
        paths[info[0]] = info[1]
      end
      if (right == " " || right == "E") && interesting_directions[2]
        right_grid = deep_dup(current_grid)
        right_grid[current_row][current_col] = "X" if current_grid[current_row][current_col] != "S"
        info = find_best_path(current_row, current_col + 1, right_grid, steps + 1, adjacents, "right")
        paths[info[0]] = info[1]
      end
      if (down == " " || down == "E") && interesting_directions[3]
        down_grid = deep_dup(current_grid)
        down_grid[current_row][current_col] = "X" if current_grid[current_row][current_col] != "S"
        info = find_best_path(current_row + 1, current_col, down_grid, steps + 1, adjacents, "down")
        paths[info[0]] = info[1]
      end
      if !paths.empty?
        paths.min_by { |path, steps2| steps2 }
      else
        return ["dead end", 999999]
      end
    end
  end
  
  def find_new_openings(previous_adjacents, adjacents, direction)
    #running into walls
    if direction == "up" && previous_adjacents[0] == " " && adjacents[0] == "*"
      return [false, true, true, false]
    elsif direction == "left" && previous_adjacents[1] == " " && adjacents[1] == "*"
      return [true, false, false, true]
    elsif direction == "right" && previous_adjacents[2] == " " && adjacents[2] == "*"
      return [true, false, false, true]
    elsif direction == "down" && previous_adjacents[3] == " " && adjacents[3] == "*"
      return [false, true, true, false]
    end
    
    #avoid open space turns
    new_openings = []
    if (previous_adjacents[0] == " " || previous_adjacents[0] == "X") && (adjacents[0] == " " || adjacents[0] == "E") && (direction != "up")
      new_openings << false
    else
      new_openings << true
    end
    if (previous_adjacents[1] == " " || previous_adjacents[1] == "X") && (adjacents[1] == " " || adjacents[1] == "E") && (direction != "left")
      new_openings << false
    else
      new_openings << true
    end
    if (previous_adjacents[2] == " " || previous_adjacents[2] == "X") && (adjacents[2] == " " || adjacents[2] == "E") && (direction != "right")
      new_openings << false
    else
      new_openings << true
    end
    if (previous_adjacents[3] == " " || previous_adjacents[3] == "X") && (adjacents[3] == " " || adjacents[3] == "E") && (direction != "down")
      new_openings << false
    else
      new_openings << true
    end
    new_openings
  end
  
  def deep_dup(two_d_array)
    new_two_d_array = []
    two_d_array.each do |array|
      new_two_d_array << array.dup
    end
    new_two_d_array
  end
  
  def display(grid)
    grid.each do |row|
      row.each do |element|
        print element
      end
      puts ""
    end
  end
  
end

debugger

Maze.new('bigmaze.txt').solve_maze