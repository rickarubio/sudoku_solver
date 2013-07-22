# This programs solves any sudoku puzzle
class SudokuGrid
  def initialize(grid_values) # should be an array of sudoku grid values
    # values go top left to right, then continue on the next row down, L to R
    # This represents a 9x9 grid
    @grid_values = grid_values
  end

  def solve
    answer_row = [1, 2, 3, 4, 5, 6, 7, 8, 9]
    working_copy = @grid_values
    # each index contains the number of occurences of that number
    # ex: [0] = 4 means 4 occurences of the number 1 in the sudoku grid
    # ex: [3] = 6 means 6 occurences of the number 4 in the sudoku grid
    # the goal is to get all array values to 9 (a complete sudoku grid)
    number_occurences = [0, 0, 0, 0, 0, 0, 0, 0, 0]
    # iterate over the 9 grid rows
    for i in 0...@grid_values.count
      @grid_values[i].each do |j|
        case j
          when 1
            number_occurences[0] += 1
          when 2
            number_occurences[1] += 1
          when 3
            number_occurences[2] += 1
          when 4
            number_occurences[3] += 1
          when 5
            number_occurences[4] += 1
          when 6
            number_occurences[5] += 1
          when 7
            number_occurences[6] += 1
          when 8
            number_occurences[7] += 1
          when 9
            number_occurences[8] += 1
        end # case
      end # each
    end # for
    for i in 0...@grid_values.count
      @grid_values[i].each do |j|
        if working_copy[j] == 0
          if number_occurences[0] <= 9
            working_copy[j] = 1
            number_occurences[0] += 1
          end # if
        end # if
      end # each
    end # for
    for i in 0...@grid_values.count
      @grid_values[i].each do |j|
        if working_copy[j] == 0
          if number_occurences[1] <= 9
            working_copy[j] = 2
            number_occurences[1] += 1
          end # if
        end # if
      end # each
    end # for
    p number_occurences
  end # method
end # class

sudoku_known_grid_values =   
  [0, 0, 3, 0, 0, 5, 0, 2, 1],
  [0, 0, 0, 0, 0, 0, 6, 3, 0],
  [4, 0, 8, 0, 3, 1, 9, 0, 0],
  [8, 0, 2, 0, 1, 6, 0, 0, 4],
  [0, 5, 1, 0, 0, 0, 8, 6, 0],
  [7, 0, 0, 3, 5, 0, 2, 0, 9],
  [0, 0, 7, 4, 8, 0, 5, 0, 6],
  [0, 4, 5, 0, 0, 0, 0, 0, 0],
  [9, 8, 0, 5, 0, 0, 1, 0, 0]
sudoku_object = SudokuGrid.new(sudoku_known_grid_values)
sudoku_object.solve