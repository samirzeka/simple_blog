class UsersController < ApplicationController

  layout "staff"
  before_filter :authorize_access

  # GETs should be safe (see http://www.w3.org/2001/tag/doc/whenToUseGet.html)
  verify :method => :post, :only => [ :destroy, :create, :update ],
    :redirect_to => { :action => :list }

  def index
    list
    render :action => 'list'
  end

  def list
    @users = User.paginate :per_page => 10, :page => params[:page]
  end

  def manage
    list
    if request.get? && params[:id].blank? #new
      @user = User.new
    elsif request.post? && params[:id].blank? #create
      @user = User.new(params[:user])
      if @user.save
        flash[:notice] = 'User was successfully created.'
        redirect_to :action => 'list'
      else
        render :action => 'new'
      end
    elsif request.get? && !params[:id].blank? #edit
      @user = User.find(params[:id])
    elsif request.post? && !params[:id].blank? #update or delete
      if params[:commit] == 'Edit'
        @user = User.find(params[:id])
        if @user.update_attributes(params[:user])
          flash[:notice] = 'User was successfully updated.'
          redirect_to :action => 'list'
        else
          render :action => 'edit'
        end
      else #action should delete
        User.find(params[:id]).destroy
        flash[:notice] = 'User was successfully deleted.'
        redirect_to :action => 'list'
      end
    end
  end
end
