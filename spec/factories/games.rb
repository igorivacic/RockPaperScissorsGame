FactoryBot.define do
  factory :games_rock_paper_scissors, class: 'Games::RockPaperScissors' do
    player_1 { Faker::DcComics.name }
    player_2 { Faker::DcComics.name }
    moves do
      [{
         player_1: 'Rock',
         player_2: 'Scissors'
       }]
    end

    trait :without_moves do
      moves { [] }
    end
  end

  factory :games_tic_tac_toe, class: 'Games::TicTacToe' do
    player_1 { "X" }
    player_2 { "O" }
    moves do
      [{ "player" => "X", "position" => 0 },
       { "player" => "O", "position" => 3 },
       { "player" => "X", "position" => 6 },
       { "player" => "O", "position" => 1 },
       { "player" => "X", "position" => 4 },
       { "player" => "O", "position" => 7 },
       { "player" => "X", "position" => 8 }]
    end

    trait :without_moves do
      moves { [] }
    end
  end
end
