# app/controllers/admin/albums_controller.rb
module Admin
    class AlbumsController < ApplicationController
      before_action :authenticate_admin!
      before_action :set_album, only: [:show, :edit, :update, :destroy]
  
      include Pagy::Backend
  
      def index
        @pagy, @albums = pagy(Album.all)
      end
  
      def show
      end
  
      def new
        @album = Album.new
      end
  
      def create
        @album = Album.new(album_params)
        if @album.save
          redirect_to admin_album_path(@album), notice: 'Album was successfully created.'
        else
          render :new
        end
      end
  
      def edit
      end
  
      def update
        if @album.update(album_params)
          redirect_to admin_album_path(@album), notice: 'Album was successfully updated.'
        else
          render :edit
        end
      end
  
      def destroy
        @album.destroy
        redirect_to admin_albums_path, notice: 'Album was successfully deleted.'
      end
  
      private
  
      def set_album
        @album = Album.find(params[:id])
      end
  
      def album_params
        params.require(:album).permit(:title, :description, :user_id, :sharing_mode)
      end
  
      def authenticate_admin!
        redirect_to root_path, alert: 'You are not authorized to access this page.' unless current_user&.admin?
      end
    end
  end
  