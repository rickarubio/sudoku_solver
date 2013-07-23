# This program solves any sudoku puzzle
# Ricardo A. Rubio
# http://www.rickarubio.com
class SudokuSolver
  def initialize(sudoku_board)
    @sudoku_rows = sudoku_board
    @sudoku_columns = sudoku_board.transpose
  end
end

sudoku_puzzle = SudokuSolver.new([
  [0, 0, 9, 1, 0, 0, 0, 0, 2],
  [0, 4, 0, 8, 0, 5, 0, 0, 0],
  [0, 8, 0, 0, 0, 0, 0, 1, 5],
  [0, 0, 5, 6, 0, 0, 0, 4, 3],
  [0, 0, 7, 9, 0, 0, 0, 2, 0],
  [0, 9, 0, 0, 5, 8, 1, 0, 0],
  [6, 0, 0, 3, 4, 0, 0, 0, 1],
  [3, 0, 8, 7, 1, 0, 0, 0, 4],
  [0, 1, 0, 0, 0, 0, 6, 0, 7]])
p sudoku_puzzle