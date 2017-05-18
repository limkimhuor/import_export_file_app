class CreateProducts < ActiveRecord::Migration[5.1]
  def change
    create_table :products do |t|
      t.string :name
      t.datetime :released_on
      t.decimal :price, :precision => 12, :scale => 8

      t.timestamps
    end
  end
end
