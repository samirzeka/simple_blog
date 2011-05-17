class User < ActiveRecord::Base

  has_many :posts, :foreign_key => 'author_id', :order => 'created_at ASC'

  has_many :recent_posts, :class_name => 'Post', :order => 'created_at ASC', :limit => 5

  validates_uniqueness_of :username

  attr_accessor :password
  #attr_accessible :first_name, :last_name, :email, :display_name, :user_level, :username, :password
  attr_protected :hashed_password, :salt

  def before_create
    self.salt = User.make_salt(self.username)
    self.hashed_password = User.hash_with_salt(@password, self.salt)
  end

  def before_update
    if !@password.blank?
      self.salt = User.make_salt(self.username) if self.salt.blank?
      self.hashed_password = User.hash_with_salt(@password, self.salt)
    end
  end

  def after_save
    @password = nil
  end

  def before_destroy
    return false if self.id == 1
  end

  def full_name
    self.first_name + " " + self.last_name 
  end

  def self.authenticate(username = "", password = "")
    user = self.find(:first, :conditions => ["username = ?", username])
    return (user && user.authenticated?(password)) ? user : nil
  end

  def authenticated?( password = "" )
    self.hashed_password == User.hash_with_salt(password, self.salt)
  end
  private #----------------

  def self.make_salt( string )
    return Digest::SHA1.hexdigest(string.to_s + Time.now.to_s)
  end

  def self.hash_with_salt(password, salt)
    return Digest::SHA1.hexdigest("Put #{salt} on the #{password}")
  end

end
