# app/controllers/admin/photos_controller.rb
module Admin
    class PhotosController < ApplicationController
      before_action :authenticate_admin!
      before_action :set_photo, only: [:show, :edit, :update, :destroy]
  
      include Pagy::Backend
  
      def index
        @pagy, @photos = pagy(Photo.all)
      end
  
      def show
      end
  
      def new
        @photo = Photo.new
      end
  
      def create
        @photo = Photo.new(photo_params)
        if @photo.save
          redirect_to admin_photo_path(@photo), notice: 'Photo was successfully created.'
        else
          render :new
        end
      end
  
      def edit
      end
  
      def update
        if @photo.update(photo_params)
          redirect_to admin_photo_path(@photo), notice: 'Photo was successfully updated.'
        else
          render :edit
        end
      end
  
      def destroy
        @photo.destroy
        redirect_to admin_photos_path, notice: 'Photo was successfully deleted.'
      end
  
      private
  
      def set_photo
        @photo = Photo.find(params[:id])
      end
  
      def photo_params
        params.require(:photo).permit(:title, :description, :user_id, :sharing_mode)
      end
  
      def authenticate_admin!
        redirect_to root_path, alert: 'You are not authorized to access this page.' unless current_user&.admin?
      end
    end
  end
  