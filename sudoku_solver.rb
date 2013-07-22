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
        if scratch_pad_grid[i].sort == answer_array
          if transposed_scratch_pad_grid[i].sort == answer_array
          puzzle_row_complete_counter += 1
          end
        end
      end
    end
    p transposed_scratch_pad_grid
    scratch_pad_grid
  end # method
end # class

sudoku_known_grid_values =[  
  [0, 0, 3, 0, 0, 5, 0, 2, 1],
  [0, 0, 0, 0, 0, 0, 6, 3, 0],
  [4, 0, 8, 0, 3, 1, 9, 0, 0],
  [8, 0, 2, 0, 1, 6, 0, 0, 4],
  [0, 5, 1, 0, 0, 0, 8, 6, 0],
  [7, 0, 0, 3, 5, 0, 2, 0, 9],
  [0, 0, 7, 4, 8, 0, 5, 0, 6],
  [0, 4, 5, 0, 0, 0, 0, 0, 0],
  [9, 8, 0, 5, 0, 0, 1, 0, 0]]
sudoku_object = SudokuGrid.new(sudoku_known_grid_values)
puts sudoku_object.solve