class CreateAds < ActiveRecord::Migration
  def change
    create_table :ads do |t|
      t.string :title
      t.text :description
      t.integer :user_id

      t.timestamps
    end
    add_index :ads, [ :user_id, :created_at ]
  end
end
