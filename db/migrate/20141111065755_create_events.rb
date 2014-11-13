class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.string :title
      t.date :starts_on
      t.boolean :recurring
      t.string :repeats
      t.references :user, index: true
    end

    add_index :events, :starts_on
    add_index :events, :recurring
    add_index :events, :repeats
  end
end
