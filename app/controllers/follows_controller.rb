class FollowsController < ApplicationController
  before_action :authenticate_user!
  before_action :find_user

  def create
      current_user.follow(@user)
      # redirect_to profile_photo_path(@user)
      redirect_back(fallback_location: root_path)
  end

  def destroy
      current_user.unfollow(@user)
      # redirect_to profile_photo_path(@user)
      redirect_back(fallback_location: root_path)
  end

  private

  def find_user
      @user = User.find(params[:id])
  end

end