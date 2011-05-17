class CreateCategories < ActiveRecord::Migration
  def self.up
    create_table :categories do |t|
	t.column :name, :string, :limit => 50, :default => "", :null => false
	t.column :short_name, :string, :limit => 30, :default => "", :null => false
	t.column :description, :string, :default => "", :null => false

      
    end
create_table :categories_posts, :id => false do |t|
t.column :category_id, :integer, :null => false
t.column :post_id, :integer, :null => false
  end
add_index :categories_posts, :category_id
add_index :categories_posts, :post_id
remove_column :blog_posts, :category
end

  def self.down
    drop_table :categories
    drop_table :categories_posts
    add_column :blog_posts, :category, :string, :limit => 20, :default => "", :null => false
  end
end
