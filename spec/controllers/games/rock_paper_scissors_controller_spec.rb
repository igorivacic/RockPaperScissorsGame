require 'games/rock_paper_scissors_game'
require 'rails_helper'

describe Games::RockPaperScissorsController, type: :controller do
  describe '#index' do
    it 'return 200' do
      get :index
      expect(subject.status).to be 200
    end
  end

  describe '#new' do
    it 'returns 200' do
      get :new
      expect(subject.status).to be 200
    end
  end

  describe '#create' do
    context 'with valid params' do
      let(:subject) { { player: 'Igor', move: 'Rock' } }

      it 'create rock paper scissors game' do
        expect {
          post :create, params: { game_params: subject } }
          .to change(Game, :count).by(1)
      end
    end
  end
end
