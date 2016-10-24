class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.string :name
      t.date :date
      t.string :city
      t.string :state

      t.timestamps null: false
      t.references :user, index: true, foreign_key: true
    end
  end
end
