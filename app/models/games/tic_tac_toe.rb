# app/models/games/tic_tac_toe.rb

require 'games/tic_tac_toe_game'

module Games
  class TicTacToe < Game
    before_update :record_winner

    def record_winner
      winner = game_logic.determine_winner

      self.winner = winner
    end

    def game_logic
      @game_logic ||= ::Games::TicTacToeGame.new(self)
    end
  end
end
