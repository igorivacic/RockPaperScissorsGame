module Games
  class
  RockPaperScissorsGame
    class Error < StandardError; end

    WIN_CHOICES = {
      'Rock' => %w[Scissors],
      'Paper' => %w[Rock],
      'Scissors' => %w[Paper]
    }.freeze

    def initialize(player_1:, player_2:)
      @player_1 = get_valid_player(player_1)
      @player_2 = get_valid_player(player_2)
    end

    def run
      return :draw if @player_1 == @player_2

      if WIN_CHOICES[@player_1].include?(@player_2)
        :player_1
      else
        :player_2
      end
    end

    def self.find_random_name
      Faker::DcComics.name
    end

    def self.find_random_move
      Games::RockPaperScissorsGame::WIN_CHOICES.keys.sample
    end

    private

    def get_valid_player(player)
      return player if WIN_CHOICES[player].present?

      raise Games::RockPaperScissorsGame::Error,
            "You must enter #{WIN_CHOICES.keys.join(',')} to play the game."
    end
  end
end
