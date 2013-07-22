# This programs solves any sudoku puzzle
class SudokuGrid
  def initialize(grid_values) # should be an array of sudoku grid values
    # values go top left to right, then continue on the next row down, L to R
    # This represents a 9x9 grid
    @grid_values = grid_values
  end

  def solve
    column_values = @grid_values.transpose
    row_values = @grid_values
    scratch_pad_grid = @grid_values
    answer_array = [1, 2, 3, 4, 5, 6, 7, 8, 9]
    puzzle_row_complete_counter = 0
    # solving code begins below here
    until puzzle_row_complete_counter >= 9 # because there are 9 rows
      transposed_scratch_pad_grid = scratch_pad_grid.transpose
      while scratch_pad_grid.flatten.include?(0) == true
        for i in 0...@grid_values.count
          scratch_pad_grid[i].each do |j|
            if j == 0
              random_number = rand(9) + 1
              until scratch_pad_grid[i].include?(random_number) == false
                # generate new random number
                random_number = rand(9) + 1
              end
              scratch_pad_grid[i][scratch_pad_grid[i].index(j)] = random_number
            end
          end
        end
      end
      # Check each row of the scratch pad
      # if the sequence of values matches the answer_array, increment the counter
      for i in 0...@grid_values.count
        if (scratch_pad_grid[i].sort == answer_array) && (transposed_scratch_pad_grid[i].sort == answer_array)
          puzzle_row_complete_counter += 1
        end
      end
      puts "-------------------------"
      p transposed_scratch_pad_grid[3].sort == answer_array
      p transposed_scratch_pad_grid[3].sort
      puts "-------------------------"
    end
    
    return scratch_pad_grid
  end # method
end # class

sudoku_known_grid_values =[  
  [5, 3, 9, 0, 6, 7, 4, 8, 0],
  [0, 4, 0, 8, 2, 5, 3, 0, 9],
  [2, 8, 6, 4, 9, 3, 7, 1, 0],
  [8, 2, 5, 0, 7, 1, 9, 4, 3],
  [1, 6, 7, 9, 3, 4, 5, 2, 8],
  [0, 9, 3, 2, 0, 0, 1, 7, 6],
  [6, 7, 2, 3, 4, 9, 8, 5, 1],
  [3, 0, 0, 7, 1, 0, 2, 9, 4],
  [9, 1, 4, 5, 8, 2, 6, 3, 7]]
sudoku_object = SudokuGrid.new(sudoku_known_grid_values)
sudoku_object.solve.each {|i| print "#{i}\n"}