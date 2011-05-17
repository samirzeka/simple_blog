class CreateComments < ActiveRecord::Migration
  def self.up
    create_table :comments do |t|
      t.column :post_id,      :integer,               :default => 0,  :null => false
      t.column :author,       :string, :limit => 25,  :default => "", :null => false
      t.column :author_email, :string, :limit => 50,  :default => "", :null => false
      t.column :content,      :text,                  :default => "", :null => false
      t.column :status,       :string, :limit => 25,  :default => "", :null => false
      t.column :created_at,   :datetime
    end
  end

  def self.down
    drop_table :comments
  end
end
