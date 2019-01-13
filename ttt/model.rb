class Game
  attr_reader :board, :X, :O
  attr_accessor :symbol, :current_turn, :space, :difficulty

  def initialize
    @board = ["0", "1", "2", "3", "4", "5", "6", "7", "8"]
    @X = "X" #computer
    @O = "O" #human
    @symbol
    @current_turn = @O
    @space
    @difficulty
  end

  def set_difficulty(setting)
    @difficulty = setting
  end

  def switch_turns
    @current_turn = @current_turn == @X ? @O : @X
  end

  def move(space)
    @space = space
    @board[@space] = @current_turn
  end

  def get_computer_move
    space_available?(4) ? @board[4] = @current_turn : @board[get_best_space] = @current_turn
  end

  def space_available?(space)
    @board[space] != "X" && @board[space] != "O"
  end

  def get_best_space
    available_spaces = []
    get_available_spaces(available_spaces)
    if @difficulty == 1
      best_move = nil
      available_spaces.each do |space|
        best_move = space.to_i
        @board[best_move] = @current_turn
        if winning_move?(space)
          puts "winnging move"
          @board[space.to_i] = space
          return best_move
        elsif block_win?(space)
          puts "block move"
          @board[space.to_i] = space
          return best_move
        elsif block_fork?(space)
          puts "block fork move"
          @board[space.to_i] = space
          return best_move
        else
          @board[best_move] = space
        end
      end
    end
    puts "random move"
    get_random_space(available_spaces)
  end

  def winning_move?(space)
    puts "checking winning move"
    move(space.to_i)
    winner
  end

  def block_win?(space)
    switch_turns
    move(space.to_i)
    switch_turns
    winner
  end

  def block_fork?(space)
  end

  #receives board array, returns array of available spaces
  def get_available_spaces(available_spaces)
    @board.each do |space|
      if space != "X" && space != "O"
        available_spaces << space
      end
    end
    return available_spaces
  end

  def get_random_space(available_spaces)
    return available_spaces.sample.to_i
  end

  def game_is_over
    winner || tie ? true : false
  end

  def winner
    [@board[0], @board[1], @board[2]].uniq.length == 1 ||
    [@board[3], @board[4], @board[5]].uniq.length == 1 ||
    [@board[6], @board[7], @board[8]].uniq.length == 1 ||
    [@board[0], @board[3], @board[6]].uniq.length == 1 ||
    [@board[1], @board[4], @board[7]].uniq.length == 1 ||
    [@board[2], @board[5], @board[8]].uniq.length == 1 ||
    [@board[0], @board[4], @board[8]].uniq.length == 1 ||
    [@board[2], @board[4], @board[6]].uniq.length == 1
  end

  def tie
    @board.all? { |space| space == "X" || space == "O" }
  end
end
