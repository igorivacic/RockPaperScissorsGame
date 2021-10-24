class Game < ApplicationRecord
  before_create :record_winner

  def record_winner
    raise NotImplementedError
  end
end
