class CreateVocabularies < ActiveRecord::Migration
  def change
    create_table :vocabularies do |t|
      t.string :word
      t.string :meaning
      
      t.timestamps
    end
  end
end
