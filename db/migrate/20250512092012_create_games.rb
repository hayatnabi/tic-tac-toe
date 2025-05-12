class CreateGames < ActiveRecord::Migration[8.0]
  def change
    create_table :games do |t|
      t.text :board
      t.string :turn
      t.timestamps
    end
  end
end
