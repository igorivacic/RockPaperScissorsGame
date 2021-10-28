require 'games/rock_paper_scissors_game'

module Games
  class RockPaperScissorsController < ApplicationController
    def new; end

    def create
      game = Games::RockPaperScissors.new
      game.player_1 = if game_params[:player].present?
                        game_params[:player]
                      else
                        Games::RockPaperScissorsGame.find_random_name
                      end
      game.player_2 = Games::RockPaperScissorsGame.find_random_name
      game.moves = init_game_moves(game_params[:move])

      if game.save
        redirect_to games_rock_paper_scissor_path(game)
      else
        render :new
      end
    end

    def show
      @game = Games::RockPaperScissors.find(params[:id])
    end

    def index
      @games = Games::RockPaperScissors.all
    end

    private

    def game_params
      params.permit(:player, :move)
    end

    def init_game_moves(move)
      [
        {
          player_1: move.present? ? move : Games::RockPaperScissorsGame.find_random_move,
          player_2: Games::RockPaperScissorsGame.find_random_move
        }
      ]
    end
  end
end
