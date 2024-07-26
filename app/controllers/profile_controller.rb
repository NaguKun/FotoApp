class ProfileController < ApplicationController
    before_action :authenticate_user!

    # My Profile
    def photo
        @user = User.find(params[:user_id])
        @photos = @user.photos.all
    end

    def album
        @user = User.find(params[:user_id])
        @albums = @user.albums.all
    end

    def follower
        @user = User.find(params[:user_id])
        @followers = @user.followers.all
    end

    def following
        @user = User.find(params[:user_id])
        @followings = @user.following.all
    end
end