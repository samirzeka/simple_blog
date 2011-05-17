require File.dirname(__FILE__) + '/../test_helper'
require 'blog_posts_controller'

# Re-raise errors caught by the controller.
class BlogPostsController; def rescue_action(e) raise e end; end

class BlogPostsControllerTest < Test::Unit::TestCase
  fixtures :blog_posts

  def setup
    @controller = BlogPostsController.new
    @request    = ActionController::TestRequest.new
    @response   = ActionController::TestResponse.new

    @first_id = blog_posts(:first).id
  end

  def test_index
    get :index
    assert_response :success
    assert_template 'list'
  end

  def test_list
    get :list

    assert_response :success
    assert_template 'list'

    assert_not_nil assigns(:blog_posts)
  end

  def test_show
    get :show, :id => @first_id

    assert_response :success
    assert_template 'show'

    assert_not_nil assigns(:blog_post)
    assert assigns(:blog_post).valid?
  end

  def test_new
    get :new

    assert_response :success
    assert_template 'new'

    assert_not_nil assigns(:blog_post)
  end

  def test_create
    num_blog_posts = BlogPost.count

    post :create, :blog_post => {}

    assert_response :redirect
    assert_redirected_to :action => 'list'

    assert_equal num_blog_posts + 1, BlogPost.count
  end

  def test_edit
    get :edit, :id => @first_id

    assert_response :success
    assert_template 'edit'

    assert_not_nil assigns(:blog_post)
    assert assigns(:blog_post).valid?
  end

  def test_update
    post :update, :id => @first_id
    assert_response :redirect
    assert_redirected_to :action => 'show', :id => @first_id
  end

  def test_destroy
    assert_nothing_raised {
      BlogPost.find(@first_id)
    }

    post :destroy, :id => @first_id
    assert_response :redirect
    assert_redirected_to :action => 'list'

    assert_raise(ActiveRecord::RecordNotFound) {
      BlogPost.find(@first_id)
    }
  end
end
