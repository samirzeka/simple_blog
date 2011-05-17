class CreatePosts < ActiveRecord::Migration
  def self.up
    create_table :posts do |t|
      t.column :title,      :string, :limit => 100, :default => "", :null => false
      t.column :content,    :text,                  :default => "", :null => false
      t.column :author_id,  :integer,               :default => 0,  :null => false
      t.column :category,   :string, :limit => 20,  :default => "", :null => false
      t.column :status,     :string, :limit => 20,  :default => "", :null => false
      t.column :created_at, :datetime
      t.column :updated_at, :datetime
    end

    add_index :posts, :author_id
  end

  def self.down
    drop_table :posts
  end
end
