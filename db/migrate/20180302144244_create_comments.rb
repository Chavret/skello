class CreateComments < ActiveRecord::Migration[5.1]
  def change
    create_table :comments do |t|
      t.string :text
      t.integer :post_id, null: false
      t.timestamps null: false
    end
  end
end
