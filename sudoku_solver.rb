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
    @possible_cell_values = generate_cell_value_possibilities(@sudoku_rows, @known_cell_values)
    eliminate_cell_value_possibilities_by_rows!(@possible_cell_values)
    eliminate_cell_value_possibilities_by_columns!(@possible_cell_values)
    eliminate_cell_value_possibilities_by_boxes!(@possible_cell_values)
    found_new_known_cell_value?(@possible_cell_values)
    keep_reducing_possibilities(@sudoku_rows, @sudoku_columns, @sudoku_boxes, @known_cell_values, @possible_cell_values)
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

  def generate_cell_value_possibilities(sudoku_rows, known_cell_values)
    possible_cell_values = [[], [], [], [], [], [], [], [], []] # arranged by row
    # Generate possible values a cell may contain
    known_cell_values.each_with_index do |row, row_index|
      row.each_with_index do |cell, cell_index|
        # cell being false means we don't know the cell's value for certain
        if cell == false
          possible_cell_values[row_index][cell_index] = [1, 2, 3, 4, 5, 6, 7, 8, 9]
          possible_cell_values[row_index][cell_index].each_with_index do |p_cell_v, p_cell_v_index|
          end
        # if the cell's value is already known, then we just mark it as [0] possibilites
        elsif cell == true
          possible_cell_values[row_index][cell_index] = []
        end
      end
    end
    possible_cell_values
  end

  def eliminate_cell_value_possibilities_by_rows!(possible_cell_values)
    @sudoku_rows.each_with_index do |row, row_index|
      row.each_with_index do |cell, cell_index|
        if possible_cell_values[row_index].flatten.index(cell) != nil
          possible_cell_values[row_index].each {|i| i.delete(cell)}
        end
      end
      #puts # remove me
    end
    #possible_cell_values.each { |r| print "#{r}  \n\n"}
  end

  def eliminate_cell_value_possibilities_by_columns!(possible_cell_values)
    possible_cell_values.each_with_index do |row, row_index|
      row.each_with_index do |element, element_column_index|
        @sudoku_columns[element_column_index].each do |column_element|
          if element.flatten.index(column_element) != nil
            element.delete(column_element)
          end
        end
      end
    end
  end

  def eliminate_cell_value_possibilities_by_boxes!(possible_cell_values)
    possible_cell_values.each_with_index do |row, row_index|
      if row_index == 0 || row_index == 1 || row_index == 2
        # check the first 3 elements of each row for eliminating box 0-2 values
        @sudoku_boxes[0].flatten.each do |number|
          (0..2).each do |element_index|
            if possible_cell_values[row_index][element_index].index(number) != nil
              possible_cell_values[row_index][element_index].delete(number)
            end
          end
        end
        @sudoku_boxes[1].flatten.each do |number|
          (3..5).each do |element_index|
            if possible_cell_values[row_index][element_index].index(number) != nil
              possible_cell_values[row_index][element_index].delete(number)
            end
          end
        end
        @sudoku_boxes[2].flatten.each do |number|
          (6..8).each do |element_index|
            if possible_cell_values[row_index][element_index].index(number) != nil
              possible_cell_values[row_index][element_index].delete(number)
            end
          end
        end
      end
      if row_index == 3 || row_index == 4 || row_index == 5
        # check the first 3 elements of each row for eliminating box 3-5 values
        @sudoku_boxes[3].flatten.each do |number|
          (0..2).each do |element_index|
            if possible_cell_values[row_index][element_index].index(number) != nil
              possible_cell_values[row_index][element_index].delete(number)
            end
          end
        end
        @sudoku_boxes[4].flatten.each do |number|
          (3..5).each do |element_index|
            if possible_cell_values[row_index][element_index].index(number) != nil
              possible_cell_values[row_index][element_index].delete(number)
            end
          end
        end
        @sudoku_boxes[5].flatten.each do |number|
          (6..8).each do |element_index|
            if possible_cell_values[row_index][element_index].index(number) != nil
              possible_cell_values[row_index][element_index].delete(number)
            end
          end
        end
      end
      if row_index == 6 || row_index == 7 || row_index == 8
        # check the first 3 elements of each row for eliminating box 6-8 values
        @sudoku_boxes[6].flatten.each do |number|
          (0..2).each do |element_index|
            if possible_cell_values[row_index][element_index].index(number) != nil
              possible_cell_values[row_index][element_index].delete(number)
            end
          end
        end
        @sudoku_boxes[7].flatten.each do |number|
          (3..5).each do |element_index|
            if possible_cell_values[row_index][element_index].index(number) != nil
              possible_cell_values[row_index][element_index].delete(number)
            end
          end
        end
        @sudoku_boxes[8].flatten.each do |number|
          (6..8).each do |element_index|
            if possible_cell_values[row_index][element_index].index(number) != nil
              possible_cell_values[row_index][element_index].delete(number)
            end
          end
        end
      end
    end
  end

  def found_new_known_cell_value?(possible_cell_values)
    # checks for cell possibilities with just 1 possibility
    # which means that is the answer for that cell
    new_known_values_found = false
    possible_cell_values.each_with_index do |row, row_index|
      row.each_with_index do |cell, cell_index|
        if cell.count == 1
          @known_cell_values[row_index][cell_index] = true
          new_known_values_found = true
        end
      end
    end
    return new_known_values_found
  end

  def find_unique_possibilities_in_box_row_column(sudoku_rows, sudoku_columns, sudoku_boxes, possible_cell_values)
    # first we will check the rows for possibilities that only occur once
    valid_values = [1,2,3,4,5,6,7,8,9]
    value_occurence_counter = [0, 0, 0, 0, 0, 0, 0, 0, 0]
    # first scan the rows for a single possibility
    possible_cell_values.each_with_index do |row, row_index|
      row.each do |cell|
        cell.each do |value|
          value_occurence_counter[(value -1)] += 1 if value != nil
        end # value
      end # cell
      value_occurence_counter.each_with_index do |occurence, occurence_index|
        if occurence == 1
          possible_cell_values[row_index].each_with_index do |cell, cell_index|
            if cell.index(occurence_index+1) != nil
              @possible_cell_values[row_index][cell_index] = [occurence_index+1]
            end
          end
        end
      end
      value_occurence_counter = [0, 0, 0, 0, 0, 0, 0, 0, 0]
    end # row
  end


  def keep_reducing_possibilities(sudoku_rows, sudoku_columns, sudoku_boxes, known_cell_values, possible_cell_values)
    @sudoku_rows = sudoku_rows
    known_cell_values.each_with_index do |row, row_index|
      row.each_with_index do |cell, cell_index|
        if (cell == true && possible_cell_values[row_index][cell_index].empty? == false)
          sudoku_rows[row_index][cell_index] = possible_cell_values[row_index][cell_index][0]
        end
      end
    end
    @sudoku_columns = @sudoku_rows.transpose
    @sudoku_boxes = create_sudoku_boxes(@sudoku_rows)
    @known_cell_values = lock_known_cell_values(@sudoku_rows)
    eliminate_cell_value_possibilities_by_rows!(@possible_cell_values)
    eliminate_cell_value_possibilities_by_columns!(@possible_cell_values)
    eliminate_cell_value_possibilities_by_boxes!(@possible_cell_values)
    if found_new_known_cell_value?(@possible_cell_values)
      keep_reducing_possibilities(@sudoku_rows, @sudoku_columns, @sudoku_boxes, @known_cell_values, @possible_cell_values)
    end
    # At this point we have reduced as many possibilities as we can
    # We have found no more single value possibilities for a cell
    find_unique_possibilities_in_box_row_column(@sudoku_rows, @sudoku_columns, @sudoku_boxes, @possible_cell_values)
    if found_new_known_cell_value?(@possible_cell_values)
      keep_reducing_possibilities(@sudoku_rows, @sudoku_columns, @sudoku_boxes, @known_cell_values, @possible_cell_values)
    end
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
          |0|1|2|
          |- - -|
          |3|4|5|
          |- - -|
          |6|7|8|
          -------"
    puts
    puts "Known Cell Values: "
    @known_cell_values.each {|cell_value_row| print cell_value_row.to_s + "\n"}
    puts
    puts "Possible cell values, before eliminating possibilities"
    possible_cell_values = generate_cell_value_possibilities(@sudoku_rows, @known_cell_values)
    possible_cell_values.each_with_index do |row, index|
      print "row #{index}:\n#{row}  \n\n"
    end

    puts "Possible cell values, AFTER eliminating possibilities"
    puts "Empty arrays [] means the value of that cell has no possibilities, b/c it is KNOWN"
    @possible_cell_values.each_with_index do |row, index|
      print "row #{index}:\n#{row}  \n\n"
    end
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

# July 22nd Puzzle
# http://www.sudokuoftheday.com/pages/s-o-t-d.php?day=3&level=5
# http://www.sudokuoftheday.com/image/image.php?size=230&sg=749312865351468927628795431582176394467839152193254786216987543874523619935641278
diabolical_sudoku = Sudoku.new([
  [0, 0, 9, 0, 0, 0, 0, 6, 0],
  [3, 0, 0, 0, 6, 0, 9, 0, 7],
  [0, 0, 8, 7, 9, 5, 0, 0, 0],
  [0, 8, 0, 0, 0, 6, 0, 0, 4],
  [0, 0, 0, 0, 3, 0, 0, 0, 0],
  [1, 0, 0, 2, 0, 0, 0, 8, 0],
  [0, 0, 0, 9, 8, 7, 5, 0, 0],
  [8, 0, 4, 0, 2, 0, 0, 0, 9],
  [0, 3, 0, 0, 0, 0, 2, 0, 0]])
sudoku_puzzle.display
diabolical_sudoku.display
