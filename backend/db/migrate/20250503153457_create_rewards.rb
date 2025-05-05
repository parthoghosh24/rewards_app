class CreateRewards < ActiveRecord::Migration[8.0]
  def change
    create_table :rewards do |t|
      t.string :title, null: false
      t.integer :points, null: false, default: 0

      t.timestamps
    end
  end
end
