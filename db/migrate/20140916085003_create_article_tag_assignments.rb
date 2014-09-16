class CreateArticleTagAssignments < ActiveRecord::Migration
  def change
    create_table :article_tag_assignments do |t|
      t.integer :tag_id
      t.integer :article_id

      t.timestamps
    end
      add_index :article_tag_assignments, :tag_id
      add_index :article_tag_assignments, :article_id
  end
end
