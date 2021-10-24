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
end