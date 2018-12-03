# Part One

##
# Initialize 2d array to represent fabric.
def draw_board(x, y)
  x_arr = []
  x.times do
    y_arr = []
    y.times do
      y_arr.push('.')
    end
    x_arr.push(y_arr)
  end
  x_arr
end

##
# Draws a pattern on the fabric.
def draw_pattern(board, id, start_x, x_mod, start_y, y_mod)
  y_mod.times do |i|
    x_mod.times do |index|
      if board[start_y+i][start_x+index] == '.'
        board[start_y+i][start_x+index] = id
      else
        board[start_y+i][start_x+index] = '#'
      end
    end
  end
  board
end

f = File.open('third_day_input.txt', 'r')
board = draw_board(1000,1000)

while line=f.gets
  args = line.scan(/\d+/)
  board = draw_pattern(board, args[0], args[1].to_i, args[3].to_i, args[2].to_i, args[4].to_i)
end

overlapped_inches = 0
board.each do |row|
  row.each do |inch|
    overlapped_inches += 1 if inch == '#'
  end
end

puts overlapped_inches

# Part Two

##
# Checks if a pattern is overlapped with another.
def is_overlapped?(board, id, start_x, x_mod, start_y, y_mod)
  found_overlap = false
  y_mod.times do |i|
    x_mod.times do |index|
      found_overlap = true unless board[start_y+i][start_x+index] == id
      end
    end
  found_overlap
end

f = File.open('third_day_input.txt', 'r')
no_overlaps = ''

while line=f.gets
  args = line.scan(/\d+/)
  no_overlaps = args[0] unless is_overlapped?(board, args[0], args[1].to_i, args[3].to_i, args[2].to_i, args[4].to_i)
end

puts no_overlaps
