# This program solves any sudoku puzzle
# Ricardo A. Rubio
# http://www.rickarubio.com
class Sudoku
  def initialize(sudoku_rows)
    # rows are ordered from top to bottom
    @sudoku_rows = sudoku_rows
    # columns are ordered from left to right
    @sudoku_columns = sudoku_rows.transpose
    # There are 9 boxes (3x3) from top left to right and continuing down
    @sudoku_boxes = create_sudoku_boxes(@sudoku_rows)
  end

  def create_sudoku_boxes(sudoku_rows)
    # There are 9 boxes (3x3) from top left to right and continuing down
    sudoku_boxes = [[], [], [], [], [], [], [], [], []]
    for i in 0..2
      sudoku_rows.each_with_index do |row, index|
        slice_start = i * 3
        sudoku_boxes[index].push row.slice(slice_start, 3)
      end
    end
    sudoku_boxes.each {|box| print box.to_s + "\n"}
  end

  def display
    puts "Your Sudoku Board (arranged by rows):"
    puts "=" * @sudoku_rows[0].to_s.length
    @sudoku_rows.each {|row| print row.to_s + "\n"}
    puts "=" * @sudoku_rows[0].to_s.length
    puts
    puts "Your Sudoku Board (arranged by column values):"
    puts "=" * @sudoku_columns[0].to_s.length
    @sudoku_columns.each {|col| print col.to_s + "\n"}
    puts "=" * @sudoku_columns[0].to_s.length
  end
end

# http://www.sudokukingdom.com/images/BlockTutorSolve.gif
sudoku_puzzle = Sudoku.new([
  [0, 0, 9, 1, 0, 0, 0, 0, 2],
  [0, 4, 0, 8, 0, 5, 0, 0, 0],
  [0, 8, 0, 0, 0, 0, 0, 1, 5],
  [0, 0, 5, 6, 0, 0, 0, 4, 3],
  [0, 0, 7, 9, 0, 0, 0, 2, 0],
  [0, 9, 0, 0, 5, 8, 1, 0, 0],
  [6, 0, 0, 3, 4, 0, 0, 0, 1],
  [3, 0, 8, 7, 1, 0, 0, 0, 4],
  [0, 1, 0, 0, 0, 0, 6, 0, 7]])
#sudoku_puzzle.display