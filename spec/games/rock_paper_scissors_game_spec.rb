require 'games/rock_paper_scissors'
require 'rails_helper'

describe Games::RockPaperScissorsGame do

  describe 'run' do
    context 'with bad arguments' do
      it 'raises exception when player_1 is nil' do
        expect {
          described_class.new(player_1: nil, player_2: 'Rock')
        }.to raise_exception Games::RockPaperScissorsGame::Error
      end

      it 'raises exception when player_2 is nil' do
        expect {
          described_class.new(player_1: 'Rock', player_2: nil)
        }.to raise_exception Games::RockPaperScissorsGame::Error
      end

      it 'raises exception when player_1 is not Rock, Paper or Scissors' do
        expect {
          described_class.new(player_1: 'Rocky', player_2: 'Balboa')
        }.to raise_exception Games::RockPaperScissorsGame::Error
      end

      it 'raises exception when player_2 is not Rock, Paper or Scissors' do
        expect {
          described_class.new(player_1: 'Lizzard', player_2: 'Eagle')
        }.to raise_exception Games::RockPaperScissorsGame::Error
      end
    end

    context 'with valid arguments' do
      subject { described_class.new(player_1: player_1, player_2: player_2) }

      context 'Rock against Rock' do
        let(:player_1) { 'Rock' }
        let(:player_2) { 'Rock' }

        it 'returns :draw' do
          expect(subject.run).to eq :draw
        end
      end

      context 'Rock against Scissors' do
        let(:player_1) { 'Rock' }
        let(:player_2) { 'Scissors' }

        it 'returns :player_1' do
          expect(subject.run).to eq :player_1
        end
      end

      context 'Rock against Paper' do
        let(:player_1) { 'Rock' }
        let(:player_2) { 'Paper' }

        it 'returns :player_2' do
          expect(subject.run).to eq :player_2
        end
      end

      context 'Paper against Rock' do
        let(:player_1) { 'Paper' }
        let(:player_2) { 'Rock' }

        it 'returns :player_1' do
          expect(subject.run).to eq :player_1
        end
      end

      context 'Paper against Scissors' do
        let(:player_1) { 'Paper' }
        let(:player_2) { 'Scissors' }

        it 'returns :player_2' do
          expect(subject.run).to eq :player_2
        end
      end

      context 'Paper against Paper' do
        let(:player_1) { 'Paper' }
        let(:player_2) { 'Paper' }

        it 'returns :draw' do
          expect(subject.run).to eq :draw
        end
      end

      context 'Scissors against Paper' do
        let(:player_1) { 'Scissors' }
        let(:player_2) { 'Paper' }

        it 'returns :player_1' do
          expect(subject.run).to eq :player_1
        end
      end

      context 'Scissors against Rock' do
        let(:player_1) { 'Scissors' }
        let(:player_2) { 'Rock' }

        it 'returns :player_2' do
          expect(subject.run).to eq :player_2
        end
      end

      context 'Scissors against Scissors' do
        let(:player_1) { 'Scissors' }
        let(:player_2) { 'Scissors' }

        it 'returns :draw' do
          expect(subject.run).to eq :draw
        end
      end
    end
  end
end
