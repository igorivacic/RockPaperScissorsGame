require 'games/rock_paper_scissors_game'

module Games
  class RockPaperScissors < Game

    def player_move(player)
      return nil if moves.blank?
      moves[0][player.to_s]
    end

    private

      def record_winner
        runner = Games::RockPaperScissorsGame.new(
          player_1: player_move(:player_1),
          player_2: player_move(:player_2)
        )

        result = runner.run

        self.winner = result.eql?(:draw) ? 'Draw' : self.attributes[result.to_s]
      end
  end
end
