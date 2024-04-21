# app/controllers/tic_tac_toe_controller.rb

require 'games/tic_tac_toe_game'

module Games
  class TicTacToeController < ApplicationController
    before_action :load_game, only: [:show, :update]

    def new; end

    def create
      @game = Games::TicTacToe.new(player_1: 'X', player_2: 'O')
      @game.save
      redirect_to games_tic_tac_toe_path(@game.id)
    end

    def show
      @player = @tic_tac_toe_game.next_player
      @winner = @tic_tac_toe_game.determine_winner
      @game_over = @tic_tac_toe_game.game_over?
    end

    def update
      begin
        player = @tic_tac_toe_game.next_player
        position = params[:position].to_i

        @tic_tac_toe_game.make_move(position, player)
        @tic_tac_toe_game.determine_winner
        @game.save
      rescue Games::TicTacToeGame::Error => e
        flash[:error] = e.message
      end
      redirect_to games_tic_tac_toe_path(@game.id)
    end

    private

      def load_game
        @game = Games::TicTacToe.find(params[:id])
        @tic_tac_toe_game = @game.game_logic
      end
  end
end
