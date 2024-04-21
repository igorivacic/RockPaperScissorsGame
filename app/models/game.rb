class Game < ApplicationRecord
  def record_winner
    raise NotImplementedError
  end
end
