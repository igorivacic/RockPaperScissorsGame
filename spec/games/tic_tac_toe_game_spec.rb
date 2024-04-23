require 'games/tic_tac_toe_game'
require 'rails_helper'

describe Games::TicTacToeGame do
  let(:game) { build(:games_tic_tac_toe, player_1: 'X', player_2: 'O', moves: moves) }
  subject { Games::TicTacToeGame.new(game) }

  describe 'next_player' do
    context 'when last move was by player O' do

      let(:moves) { [{ player: 'O', position: 1 }] }

      it 'returns X' do
        expect(subject.next_player).to eq("X")
      end
    end

    context 'when last move was by player X' do
      let(:moves) { [{ player: 'X', position: 1 }] }

      it 'returns O' do
        expect(subject.next_player).to eq("O")
      end
    end

    context 'when no moves have been made' do
      let(:moves) { [] }

      it 'returns X' do
        expect(subject.next_player).to eq("X")
      end
    end
  end

  describe '#make_move' do
    context 'with invalid moves game_over' do
      let(:moves) { [{ "player" => "X", "position" => 0 },
                     { "player" => "O", "position" => 3 },
                     { "player" => "X", "position" => 6 },
                     { "player" => "O", "position" => 1 },
                     { "player" => "X", "position" => 4 },
                     { "player" => "O", "position" => 7 },
                     { "player" => "X", "position" => 8 }] }

      it 'raises an error if the game is over' do
        # allow(subject).to receive(:game_over?).and_return(true)
        expect { subject.make_move(1, "X") }.to raise_error(Games::TicTacToeGame::Error, 'Game is already over.')
      end
    end


    context 'with invalid moves position out of bounds' do
      let(:moves) { [{ "player" => "X", "position" => 1 },
                     { "player" => "O", "position" => 1 }] }
      it 'raises an error if the position is out of bounds' do
        expect { subject.make_move(10, "X") }.to raise_error(Games::TicTacToeGame::Error, 'Invalid move! The position is out of bounds.')
      end
    end

    context 'with invalid moves position taken' do
      let(:moves) { [{ "player" => "X", "position" => 1 },
                     { "player" => "O", "position" => 1 }] }
      it 'raises an error if the position is already taken' do
        subject.make_move_player_1(1)
        expect { subject.make_move_player_2(1) }.to raise_error(Games::TicTacToeGame::Error, 'Invalid move! The position is already taken.')
      end
    end
  end

  describe '#game_over?' do
    context 'when game is not over' do
      let(:moves) { [{ "player" => "X", "position" => 0 }] }

      it 'returns false when the game starts' do
        expect(subject.game_over?).to be false
      end
    end

    context 'when game is over' do
      let(:moves) { [
        { "player" => "X", "position" => 0 },
        { "player" => "O", "position" => 3 },
        { "player" => "X", "position" => 1 },
        { "player" => "O", "position" => 4 },
        { "player" => "X", "position" => 2 }
      ] }

      it 'returns true when all positions are taken' do
        expect(subject.game_over?).to be true
      end
    end

  end

  describe '#winner?' do
    context 'when there is a winning combination' do
      let(:moves) { [{ "player" => "X", "position" => 0 },
                     { "player" => "O", "position" => 3 },
                     { "player" => "X", "position" => 6 },
                     { "player" => "O", "position" => 1 },
                     { "player" => "X", "position" => 4 },
                     { "player" => "O", "position" => 7 },
                     { "player" => "X", "position" => 8 }] }

      it 'returns true' do
        expect(subject.winner?).to be true
      end
    end
  end

  describe '#determine_winner' do
    context 'when there is a draw combination' do
      let(:moves) { [
        { "player" => "X", "position" => 0 },
        { "player" => "O", "position" => 2 },
        { "player" => "X", "position" => 1 },
        { "player" => "O", "position" => 5 },
        { "player" => "X", "position" => 3 },
        { "player" => "O", "position" => 6 },
        { "player" => "X", "position" => 4 }
      ] }

      it "announces the winner or declares a draw" do
        expect(subject.winner?).to be false
      end
    end
  end
end