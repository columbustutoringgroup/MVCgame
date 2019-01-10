module View
  module Print
    class << self
      def tell_user(message)
        puts message
      end

      def welcome
        tell_user "Welcome to Tic Tac Toe!"
      end

      def render_board(game)
        Print::tell_user(
          " #{game.board[0]} | #{game.board[1]} | #{game.board[2]} \n===+===+===\n #{game.board[3]} | #{game.board[4]} | #{game.board[5]} \n===+===+===\n #{game.board[6]} | #{game.board[7]} | #{game.board[8]} \n"
        )
      end

      def ask_symbol(game)
        tell_user("Do you want to be X or O?")
        gets.chomp
      end

      def acceptable_moves
        tell_user "Please enter a unique number between 0-8."
      end

      def report_winner(current_turn)
        tell_user "Game over. #{current_turn} won."
      end

      def report_tie
        tell_user "Game over. Tied game."
      end

      def report_move(current_turn, spot)
        tell_user "#{current_turn}'s move: #{spot}"
      end
    end
  end
end
