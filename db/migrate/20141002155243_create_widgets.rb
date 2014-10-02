class CreateWidgets < ActiveRecord::Migration
  def change
    create_table :widgets do |t|
      t.string :name
      t.text :description
      t.integer :picture
      t.decimal :price

      t.timestamps
    end
  end
end
