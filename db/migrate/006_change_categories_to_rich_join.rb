class ChangeCategoriesToRichJoin < ActiveRecord::Migration
  def self.up
	add_column :categories_posts, :id, :primary_key
	# this might seem right, but its not:
	#add_column :categories_posts, :id, :integer
	#add_index :categories_posts, :id
  end

  def self.down
	remove_column :categories_posts, :id
  end
end

