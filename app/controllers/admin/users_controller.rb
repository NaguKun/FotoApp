module Admin
    class UsersController < ApplicationController
      before_action :authenticate_admin!
      before_action :set_user, only: [:show, :edit, :update, :destroy]
  
      include Pagy::Backend
  
      def index
        @pagy, @users = pagy(User.all)
      end
  
      def show
      end
  
      def new
        @user = User.new
      end
  
      def create
        @user = User.new(user_params)
        if @user.save
          redirect_to admin_user_path, notice: 'User was successfully created.'
        else
          render :new
        end
      end
  
      def edit
      end
  
      def update
        if @user.update(user_params)
          redirect_to admin_user_path(@user), notice: 'User was successfully updated.'
        else
          render :edit
        end
      end
    
      def destroy
        if @user.destroy
          redirect_to admin_users_path, notice: 'User was successfully deleted.'
        else
          redirect_to admin_users_path, alert: 'Error deleting user.'
        end
      end
  
      private
  
      def set_user
        @user = User.find(params[:id])
      end
  
      def user_params
        params.require(:user).permit(:firstname, :lastname, :username, :email, :role)
      end
  
      def authenticate_admin!
        redirect_to root_path, alert: 'You are not authorized to access this page.' unless current_user&.admin?
      end
    end
  end
  