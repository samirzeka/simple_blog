class Post < ActiveRecord::Base

set_table_name "blog_posts"

belongs_to :author, :class_name => 'User', :foreign_key => 'author_id'
has_many :comments, :order => 'created_at ASC', :dependent => :destroy
has_many :approved_comments, :class_name => 'Comment', :conditions => "comments.status = 'approved'"
has_many :categorizations
has_many :categories, :through => :categorizations
  
  
end
