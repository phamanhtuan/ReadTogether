class CreateTranslations < ActiveRecord::Migration
  def change
    create_table :translations do |t|
   	  t.string :meaning
   	  t.integer :vocabulary_id

      t.timestamps
    end
    add_index :translations, :vocabulary_id
  end
end
