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

    until puzzle_row_complete_counter == 2
      # erase the scratchpad and try again
      scratch_pad_grid = @grid_values

      for i in 0...@grid_values.count
        for j in 0...@grid_values.count
          # moving from left to right, then advancing to the next row
          if scratch_pad_grid[j][i] == 0
            random_number = rand(9) + 1
            scratch_pad_grid[j][i] = random_number if scratch_pad_grid[i].each {|num| num != random_number}
          end # if
        end # for j
      end # for i



      for i in 0...@grid_values.count
        p scratch_pad_grid[i].sort
        if scratch_pad_grid[i].sort == answer_array
          puzzle_row_complete_counter += 1
        end
      end

    end # until
    puts scratch_pad_grid
    puts "koalas"
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
sudoku_object.solve