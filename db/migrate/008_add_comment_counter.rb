class AddCommentCounter < ActiveRecord::Migration
  def self.up
    add_column :blog_posts, :comments_count, :integer, :limit => 4, :default => 0, :null => false
    Post.find(:all).each do |post|
      current_count = post.comments.length
      post.update_attribute(:comments_count, current_count)
    end
  end

  def self.down
    remove_column :blog_posts, :comments_count
  end
end
