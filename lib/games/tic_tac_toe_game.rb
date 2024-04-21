module Games
  class TicTacToeGame
    class Error < StandardError; end

    WINNING_COMBINATIONS = [
      [0, 1, 2], [3, 4, 5], [6, 7, 8], # Rows
      [0, 3, 6], [1, 4, 7], [2, 5, 8], # Columns
      [0, 4, 8], [2, 4, 6] # Diagonals
    ].freeze

    def initialize(game)
      @game = game
      @board = Array.new(9)
      setup_board_from_moves
    end

    def next_player
      last_move = @game.moves.last
      if last_move.nil? || last_move['player'] == 'O'
        return "X"

      elsif last_move['player'] == 'X'
        return "O"
      end
    end

    def make_move_player_1(position)
      make_move(position, "X")
    end

    def make_move_player_2(position)
      make_move(position, "O")
    end

    def make_move(position, player)
      raise Error, 'Game is already over.' if game_over?
      position -= 1
      raise Error, 'Invalid move! The position is out of bounds.' unless (0..8).include?(position)
      raise Error, 'Invalid move! The position is already taken.' if @board[position]
      @board[position] = player
      @game.moves << { player: player, position: position }
      @game.save!
    end

    def game_over?
      @board.all?(&:nil?) == false && (winner? || @board.none?(&:nil?))
    end

    def winner?
      WINNING_COMBINATIONS.any? do |combo|
        first_mark = @board[combo[0]]
        combo.all? { |pos| @board[pos] == first_mark && !first_mark.nil? }
      end
    end

    def determine_winner
      return "draw" unless winner?
      WINNING_COMBINATIONS.each do |combo|
        if combo.all? { |pos| @board[pos] == @game.player_1 }
          return @game.player_1
        elsif combo.all? { |pos| @board[pos] == @game.player_2 }
          return @game.player_2
        end
      end
    end


    def current_board_state
      @board.dup
    end

    private

      def setup_board_from_moves
        @game.moves.each do |move|
          player = move['player']
          position = move['position']
          @board[position] = player
        end
      end
  end
end