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
    @known_cell_values = lock_known_cell_values(@sudoku_rows)
  end

  def create_sudoku_boxes(sudoku_rows)
    # There are 9 boxes (3x3) from top left to right and continuing down
    sudoku_groupings = [[], [], [], [], [], [], [], [], []]
    sudoku_boxes = [[], [], [], [], [], [], [], [], []]
    (0..2).each_with_index do |obj, i|
      sudoku_rows.each_with_index do |row, index|
        slice_start = i * 3
        sudoku_groupings[index].push row.slice(slice_start, 3)
      end
    end
    #sudoku_groupings.each {|box| print box.to_s + "\n"} # for testing

    # The values obtained above must now be properly interpreted for
    # the sudoku box objects (3x3 squares) top left is box1, bottom right box9
    for box_index in 0..8
      sudoku_groupings.each_with_index do |row, row_index|
        # form box 0 (the top left corner sudoku box)
        if box_index == 0 && row_index == 0 || box_index == 0 && row_index == 1 || box_index == 0 && row_index == 2
          sudoku_boxes[box_index].push row[0]
        elsif box_index == 1 && row_index == 0 || box_index == 1 && row_index == 1 || box_index == 1 && row_index == 2
          sudoku_boxes[box_index].push row[1]
        elsif box_index == 2 && row_index == 0 || box_index == 2 && row_index == 1 || box_index == 2 && row_index == 2
          sudoku_boxes[box_index].push row[2]
        elsif box_index == 3 && row_index == 3 || box_index == 3 && row_index == 4 || box_index == 3 && row_index == 5
          sudoku_boxes[box_index].push row[0]
        elsif box_index == 4 && row_index == 3 || box_index == 4 && row_index == 4 || box_index == 4 && row_index == 5
          sudoku_boxes[box_index].push row[1]
        elsif box_index == 5 && row_index == 3 || box_index == 5 && row_index == 4 || box_index == 5 && row_index == 5
          sudoku_boxes[box_index].push row[2]
        elsif box_index == 6 && row_index == 6 || box_index == 6 && row_index == 7 || box_index == 6 && row_index == 8
          sudoku_boxes[box_index].push row[0]
        elsif box_index == 7 && row_index == 6 || box_index == 7 && row_index == 7 || box_index == 7 && row_index == 8
          sudoku_boxes[box_index].push row[1]
        elsif box_index == 8 && row_index == 6 || box_index == 8 && row_index == 7 || box_index == 8 && row_index == 8
          sudoku_boxes[box_index].push row[2]
        end
      end
      box_index += 1
    end
    sudoku_boxes
    #sudoku_boxes.each_with_index {|box, index| print " box #{index}" + box.to_s + "\n"} # for testing
  end

  def lock_known_cell_values(sudoku_rows)
    known_cell_values = [[], [], [], [], [], [], [], [], []]
    sudoku_rows.each_with_index.map { |row, row_index| row.map {|cell| 
      cell == 0 ? known_cell_values[row_index].push(false) : known_cell_values[row_index].push(true)} }
    known_cell_values
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
    puts
    puts "Your Sudoku Boxes by the Number:"
    @sudoku_boxes.each_with_index {|box, index| print " box #{index}: " + box.to_s + "\n"}
    puts
    puts "box guide map:"
    print "read as [[top values], [middle values], [bottom values]] of the sudoku box"
    puts "
          -------
          |1|2|3|
          |- - -|
          |4|5|6|
          |- - -|
          |7|8|9|
          -------"
    puts "Known Cell Values: "
    @known_cell_values.each {|cell_value_row| print cell_value_row.to_s + "\n"}

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
sudoku_puzzle.display