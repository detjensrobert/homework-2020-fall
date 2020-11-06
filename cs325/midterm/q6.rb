#!/usr/bin/ruby

def white_squares_score (board)
  scores = Array.new(board.size) { Array.new(board.size) }
  puts scores.to_s

  board.reverse.each_with_index do |e, i|
    puts "#{e} #{i}"
  end
end

board = [
  %w(-1 7 -8 10 -5),
  %w(-4 -9 8 -6 0),
  %w(5 -2 -6 6 7),
  %w(-7 4 7 -3 -3),
  %w(7 1 -6 4 -3),
].map!{|r| r.map! {|e| e.to_i } }

puts board.to_s

white_squares_score board
