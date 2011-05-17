class PostsController < ApplicationController
	layout "staff"
	before_filter :authorize_access
  def index
    list
    render :action => 'list'
  end

  # GETs should be safe (see http://www.w3.org/2001/tag/doc/whenToUseGet.html)
  verify :method => :post, :only => [ :destroy, :create, :update ],
         :redirect_to => { :action => :list }

  def list
    @posts = Post.paginate :per_page => 10, :page => params[:page]
  end

  def show
    # this action will preview the public view of the post
    @post = Post.find(params[:id])
    @all_categories = Category.find(:all, :order => 'name ASC')
    render(:template => 'shared/view_post', :layout => 'application')
  end
  alias :view_post :show

  def new
    @post = Post.new
    @user_list = get_user_list
    @all_categories = get_all_categories
  end

  def create
    post_params = params[:post]
    author_id = post_params.delete(:author_id)
    @all_categories = get_all_categories
    checked_categories = get_categories_from(params[:categories])
    removed_categories = @all_categories - checked_categories
    @post = Post.new(post_params)
    @post.author = User.find(author_id)

    if @post.save
      checked_categories.each {|cat| @post.categories << cat if 
        !@post.categories.include?(cat) }
        removed_categories.each {|cat| @post.categories.delete(cat) if 
          @post.categories.include?(cat) }
          flash[:notice] = 'Post was successfully created.'
          redirect_to :action => 'list'
    else
      @user_list = get_user_list	  
      render :action => 'new'
    end
  end

  def edit
    @post = Post.find(params[:id])
    @user_list = get_user_list
    @all_categories = get_all_categories
  end

  def update
    post_params = params[:post]
    author_id = post_params.delete(:author_id)
    @all_categories = get_all_categories
    checked_categories = get_categories_from(params[:categories])
    removed_categories = @all_categories - checked_categories
    @post = Post.find(params[:id])
    @post.author = User.find(author_id) if @post.author_id != author_id
    if @post.update_attributes(post_params)
      checked_categories.each {|cat| @post.categories << cat if 
        !@post.categories.include?(cat) }
        removed_categories.each {|cat| @post.categories.delete(cat) if 
          @post.categories.include?(cat) }
          flash[:notice] = 'Post was successfully updated.'
          redirect_to :action => 'list'
    else
      @user_list = get_user_list
      render :action => 'edit'
    end
  end

  def destroy
    Post.find(params[:id]).destroy
    redirect_to :action => 'list'
  end
  private #---------------------------

  def get_user_list
    return User.find(:all, :order => 'last_name ASC').collect {|user| [user.full_name, user.id]}
  end
  def get_all_categories
    return Category.find(:all, :order => 'name ASC')
  end

  def get_categories_from(cat_list)
    cat_list = [] if cat_list.blank?
    return cat_list.collect {|cid| Category.find_by_id(cid.to_i)}.compact
  end

end
