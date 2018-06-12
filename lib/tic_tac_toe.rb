board = [" ", " ", " ", " ", " ", " ", " ", " ", " "]
def display_board(board)
  puts " #{board[0]} | #{board[1]} | #{board[2]} "
  puts "-----------"
  puts " #{board[3]} | #{board[4]} | #{board[5]} "
  puts "-----------"
  puts " #{board[6]} | #{board[7]} | #{board[8]} "
end

WIN_COMBINATIONS = [
  [0,1,2],
  [0,4,8],
  [0,3,6],
  [1,4,7],
  [2,4,6],
  [2,5,8],
  [3,4,5],
  [6,7,8]
]

# input_to_index
def input_to_index(input)
  input.to_i - 1
end

# move
def move(board, index, character)
  board[index] = character
end

# position_taken
def position_taken?(board, index)
  !(board[index].nil? || board[index] == " ")
end

# valid_move
def valid_move?(board, index)
  index.between?(0,8) && !position_taken?(board, index)
end

# turn
def turn(board)
  character = current_player(board)
  puts "Please enter 1-9:"
  input = gets.strip
  index = input_to_index(input)
  if valid_move?(board, index)
    move(board, index, character)
    # display_board(board)
  else
    until valid_move?(board, index)
      puts "Please enter 1-9:"
      input = gets.strip
      index = input_to_index(input)
    end
    move(board, index, character)
  end
  display_board(board)
end

# turn_count
def turn_count(board)
  counter = 0
  board.each do |i|
    if i == "X" || i == "O"
      counter += 1
    end
  end
return counter
end

# current_player
def current_player(board)
  counter = turn_count(board)
  if counter % 2 == 0
    return "X"
  else
    return "O"
  end
end

# won
def won?(board)
  WIN_COMBINATIONS.each do |combo|
    if board[combo[0]] == "X" && board[combo[1]] == "X" && board[combo[2]] == "X"
      return combo
    elsif board[combo[0]] == "O" && board[combo[1]] == "O" && board[combo[2]] == "O"
      return combo
    end
  end
  return false
end

# full
def full?(board)
  if board.include? " "
    return false
  else
    return true
  end
end

# draw
def draw?(board)
  if !won?(board) && full?(board)
    return true
  else
    return false
  end
end

# over
def over?(board)
  if draw?(board)==true || won?(board)!=false
    return true
  else
    return false
  end
end

# winner
def winner(board)
  if won?(board)
    combo = won?(board)
    winner_winner_chicken_dinner = combo[0]
    if board[winner_winner_chicken_dinner] == "X"
      return "X"
    else
      return "O"
    end
  end
end

# play
def play(board)
  while !over?(board)
    turn(board)
  end
  if won?(board)
    winner = winner(board)
    puts "Congratulations #{winner}!"
  elsif draw?(board)
    puts "Cat's Game!"
  end
#   counter = 0
#   while counter<9
#     turn(board)
#     counter += 1
#   end
#   if won?(board)
#     winner = winner(board)
#     puts "Congratulations #{winner}!"
#   elsif draw?(board)
#     puts "Cat's Game!"
#   end
end
