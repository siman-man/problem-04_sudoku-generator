# -*- encoding: utf-8 -*-

require './sudoku_helper'

#level 1 - 4 まであります
board = board_by_level "4"


#nil になっている部分を1~9で埋めましょう
#

class Solve
  def initialize(board)
    @board_list = []
    @board_list << Marshal.load(Marshal.dump(board))
  end

  def solve
    loop do
      tmp_board = @board_list.pop
      flag = false

      return tmp_board if sudoku_complete? tmp_board

      9.times do |y|
        9.times do |x|
          if tmp_board[x][y].nil?
            1.upto(9) do |num|
              tmp_board[x][y] = num
              if sudoku_check tmp_board 
                 @board_list <<  Marshal.load(Marshal.dump(tmp_board))
                #puts "insert! #{num}"
              end
            end
            flag = true
          end
          break if flag
        end
        break if flag
      end
    end
  end

  def board_fill_check b
    9.times do |y|
      9.times do |x|
        return false if b[x][y].nil?
      end
    end

    return true
  end
end
s = Solve.new(board)

res = s.solve

sudoku_print res

if sudoku_check res
  if sudoku_complete? res
    puts "complete!"
  else
    puts "not yet"
  end
else
  puts "error!"
end
