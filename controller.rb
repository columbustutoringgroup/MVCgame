require_relative "model"
require_relative "view"

class Controller
  def execute
    loop do
      run_menu
      input = gets.chomp.upcase
      print "\n"
      sleep 1
      case input
      when "S"
        run_game
      when "R"
        display_move_list
      when "Q"
        quit_gracefully
      else
        puts "You aren't very good at this, are you?"
      end
      sleep 1
    end
  end

  private
    def run_menu
      Menu.new.list_options
    end

    def quit_gracefully
      puts "Quitting gracefully..."
      print "\n"
      sleep 2
      %x( ^c )
    end

    def display_move_list
      if @game
        puts "\tX\t|\tO\t"
        puts "----------------+-----------------"
        @game.move_list.each_slice(2) do |pair|
          x1 = pair[0].loc[:x] + 1
          y1 = pair[0].loc[:y] + 1
          print "\t#{x1}, #{y1}\t|"
          if pair[1]
            x2 = pair[1].loc[:x] + 1
            y2 = pair[1].loc[:y] + 1
            print "\t#{x2}, #{y2}"
          end
          print "\n"
        end
      else
        puts "No last game to review."
      end
    end

    def run_game
      @game = Game.new
      @board = Board.new
      @board.draw
      while !@game.winner? do
        new_move
      end
      sleep 1
      print "It's over. "
      if @game.winner? == "X" || @game.winner? == "O"
        puts "#{@game.winner?}'s win."
      else
        puts "It's a tie.  How dull..."
      end
    end

    def new_move
      input = get_input
      while !valid?(input) do 
        input = get_input
      end
      move = Move.new(input)
      @game.register(move)
      @board.add_to_pixel_array(move)
      @board.draw
    end

    def get_input
      print "row (1-3): "
      x = gets.chomp.to_i - 1
      print "column (1-3): "
      y = gets.chomp.to_i - 1
      {x: x, y: y}
    end

    def valid?(input)
      x = input[:x]
      y = input[:y]
      if x < 0 || x > 2 || y < 0 || y > 2
        puts "That move is out of bounds"
        false
      elsif !@game.grid[x][y].nil?
        puts "That square is already full"
        false
      else
        true
      end
    end

end

Controller.new.execute

