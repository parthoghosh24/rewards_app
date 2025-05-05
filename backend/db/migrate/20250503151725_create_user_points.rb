class CreateUserPoints < ActiveRecord::Migration[8.0]
  def change
    create_table :user_points do |t|
      t.references :user, null: false, foreign_key: true
      t.integer :points, default: 0

      t.timestamps
    end
  end
end
