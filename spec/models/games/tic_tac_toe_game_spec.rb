require 'rails_helper'

describe Games::TicTacToe do
  describe 'db columns' do
    it { should have_db_column(:id).of_type(:integer) }
    it { should have_db_column(:player_1).of_type(:string) }
    it { should have_db_column(:player_2).of_type(:string) }
    it { should have_db_column(:type).of_type(:string) }
    it { should have_db_column(:winner).of_type(:string) }
    it { should have_db_column(:created_at).of_type(:datetime) }
    it { should have_db_column(:updated_at).of_type(:datetime) }
  end

  describe 'callbacks' do
    describe 'before update' do
      subject { create(:games_tic_tac_toe, player_1: 'X', player_2: 'O', moves: moves) }

      context 'when a winner is determined' do
        let(:moves) { [{ "player" => "X", "position" => 0 },
                       { "player" => "O", "position" => 3 },
                       { "player" => "X", "position" => 6 },
                       { "player" => "O", "position" => 1 },
                       { "player" => "X", "position" => 4 },
                       { "player" => "O", "position" => 7 }
        ] }

        let(:last_move) { { "player" => "X", "position" => 8 } }

        it 'records the winner' do
          subject.moves << last_move
          subject.save
          expect(subject.winner).to eq 'X'
        end
      end

      context 'when the game is a draw' do
        let(:moves) do
          [
            { "player" => "X", "position" => 1 },
            { "player" => "O", "position" => 5 },
            { "player" => "X", "position" => 3 },
            { "player" => "O", "position" => 2 },
            { "player" => "X", "position" => 8 },
            { "player" => "O", "position" => 6 },
            { "player" => "X", "position" => 4 },
            { "player" => "O", "position" => 7 }
          ]
        end

        let(:last_move) { { "player" => "X", "position" => 9 } }


        it 'records a draw' do
          subject.moves << last_move
          subject.save
          expect(subject.winner).to eq 'draw'
        end
      end
    end
  end

  describe '#game_logic' do
    subject { create(:games_tic_tac_toe) }

    it 'returns an instance of TicTacToe' do
      expect(subject.game_logic).to be_an_instance_of(Games::TicTacToeGame)
    end

    it 'caches the game logic object' do
      first_instance = subject.game_logic
      expect(subject.game_logic).to be(first_instance)
    end
  end
end
