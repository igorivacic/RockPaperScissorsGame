require 'rails_helper'

describe Games::RockPaperScissors do
  describe '#callbacks' do
    describe 'before save' do
      describe 'record_winner' do
        subject { build(:games_rock_paper_scissors, player_1: player_1, player_2: player_2, moves: moves) }

        let(:player_1) { 'Rocky Balboa'}
        let(:player_2) { 'Scissor Man'}

        before do
          subject.save
        end

        context 'with valid player moves' do
          let(:moves) do
            [{
               player_1: 'Rock',
               player_2: 'Scissors'
             }]
          end

          it 'records the winner name' do
            expect(subject.winner).to eq player_1
          end
        end

        # context 'with invalid player moves' do
        #   let(:moves) { [] }
        #
        #   it 'adds model error and prevents record from saving' do
        #     expect(subject.errors).to include 'Bla'
        #     expect(subject.persisted?).to eq false
        #   end
        # end

        context 'when draw' do
          let(:moves) do
            [{
               player_1: 'Rock',
               player_2: 'Rock'
             }]
          end

          it 'records :draw' do
            expect(subject.winner).to eq 'Draw'
          end
        end
      end
    end
  end

  describe 'player_move' do
    context 'without moves' do
      subject { build(:games_rock_paper_scissors, :without_moves) }

      it 'returns nil' do
        expect(subject.player_move(:player_1)).to be_nil
      end
    end

    context 'with moves' do
      subject { build(:games_rock_paper_scissors) }

      context 'when player_1 is given as an argument' do
        it 'returns player 1 move' do
          expect(subject.player_move(:player_1)).to eq 'Rock'
        end
      end

      context 'when player_2 is given as an argument' do
        it 'returns player 2 move' do
          expect(subject.player_move(:player_2)).to eq 'Scissors'
        end
      end

      context 'when random player is given as an argument' do
        it 'returns nil' do
          expect(subject.player_move(:random_player)).to be_nil
        end
      end
    end
  end
end