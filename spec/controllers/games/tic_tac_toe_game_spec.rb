require 'games/tic_tac_toe_game'
require 'rails_helper'

describe Games::TicTacToeController, type: :controller do
  describe '#new' do
    it 'returns 200' do
      get :new
      expect(response.status).to be 200
    end
  end

  describe '#create' do
    context 'with valid params' do
      it 'creates a new TicTacToe game' do
        expect do
          post :create
        end.to change(Games::TicTacToe, :count).by(1)
      end
    end
  end

  describe '#show' do
    let(:game) { Games::TicTacToe.create(player_1: 'X', player_2: 'O') }

    it 'returns 200' do
      get :show, params: { id: game.id }
      expect(response.status).to be 200
    end

    it 'assigns @game and @tic_tac_toe_game' do
      get :show, params: { id: game.id }
      expect(assigns(:game)).to eq(game)
      expect(assigns(:tic_tac_toe_game)).to be_a(Games::TicTacToeGame)
    end
  end

  describe '#update' do
    let(:game) { Games::TicTacToe.create(player_1: 'X', player_2: 'O') }

    context 'with valid params' do
      it 'makes a move and redirects to show page' do
        post :update, params: { id: game.id, games_tic_tac_toe: { player: 'X', position: '0' } }
        expect(response).to redirect_to(games_tic_tac_toe_path(game.id))
      end
    end
  end
end

