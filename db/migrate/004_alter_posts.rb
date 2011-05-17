class AlterPosts < ActiveRecord::Migration
  def self.up
    add_column :posts, :updated_at, :datetime
    rename_table :posts, :blog_posts
    rename_column :blog_posts, :body, :content
    change_column :blog_posts, :author, :integer, :default => 0, :null => false
    rename_column :blog_posts, :author, :author_id
    add_index :blog_posts, :author_id
  end

  def self.down
    remove_column :blog_posts, :updated_at
    remove_index :blog_posts, :author_id
    rename_table :blog_posts, :posts
    rename_column :posts, :content, :body
    rename_column :posts, :author_id, :author
    change_column :posts, :author, :string, :limit => 100, :default => 0, :null => false
  end
end

