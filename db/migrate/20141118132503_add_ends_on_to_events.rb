class AddEndsOnToEvents < ActiveRecord::Migration
  def change
    add_column :events, :ends_on, :date
    add_index :events, :ends_on
  end
end
