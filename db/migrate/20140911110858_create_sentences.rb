class CreateSentences < ActiveRecord::Migration
  def change  
    create_table :sentences do |t|
      t.text :content
      t.integer :article_id
      t.integer :paragraph
      t.integer :position
      t.string	:end_symbol
      t.timestamps
    end
    add_index :sentences, :article_id
  end
end


