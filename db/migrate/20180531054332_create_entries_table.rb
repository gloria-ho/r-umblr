class CreateEntriesTable < ActiveRecord::Migration[5.2]
  def change
    create_table :entries do |entry|
      entry.integer :user
      entry.integer :post
    end
  end
end
