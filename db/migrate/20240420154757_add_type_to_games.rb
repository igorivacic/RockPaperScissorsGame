class AddTypeToGames < ActiveRecord::Migration[6.1]
  def change
    add_column :games, :type, :string
  end
end
