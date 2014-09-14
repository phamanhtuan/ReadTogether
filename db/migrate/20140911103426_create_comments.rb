class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.integer :sentence_id
      t.text :content

      t.timestamps
    end
    add_index :comments, :sentence_id
  end
end
