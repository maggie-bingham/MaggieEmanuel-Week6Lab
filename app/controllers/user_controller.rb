class UserController < ApplicationController
  #  attr_accessible :email, :username, :user_bio, :user_photo

  def new
    @user = User.new
  end

  def index
    @user = User.all
  end

  def edit
    @user = User.find(params[:id])
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
    @user = User.find(:followable_id)
      if current_user == @user
        render "You cannot follow yourself"
      else
        current_user.follow(@user)
        render "You are now following #{@user}"
      end
      redirect_to :back
  end

  def unfollow
    if current_user
      current_user.stop_following(@user)
        render "You are no longer following #{@user.email}."
      redirect_to :back
    else
      render "You must sign in to unfollow #{@user.email}."
    end
  end

end
