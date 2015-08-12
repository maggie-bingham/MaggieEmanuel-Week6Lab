
class UserController < ApplicationController
  attr_accessor :email, :username, :user_bio, :user_photo

  def new
    @user = User.new
  end

  def index
    @user = User.all
  end

  def edit
  end

  def create
    @user = User.new(user_params)
      if @user.save
        redirect_to @user
      else
        render 'new'
      end
  end

  def show
    @user = User.find(params[:id])
  end

  def follow

    @user = User.find(params[:id])
      if current_user == @user
      flash[:notice] = "You are cannot follow yourself"
      else
        current_user.follow(@user)
      end
      redirect_to :posts
  end

  def unfollow
    @user = User.find(params[:id])
        current_user.stop_following(@user)
        redirect_to :posts
  end

end
