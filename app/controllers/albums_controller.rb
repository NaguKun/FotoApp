class AlbumsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  before_action :set_album, only: [:show, :edit, :update, :destroy]
  
  def index
    @albums = Album.public_albums.order(created_at: :desc)
  end

  def show
  end

  def new
    @album = current_user.albums.build
  end

  def create
    @album = current_user.albums.build(album_params)
    if @album.save
      redirect_to @album, notice: 'Album was successfully created.'
    else
      render :new
    end
  end

  def edit
    authorize @album
  end

  def update
    authorize @album
    if @album.update(album_params)
      redirect_to @album, notice: 'Album was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    authorize @album
    @album.destroy
    redirect_to albums_url, notice: 'Album was successfully deleted.'
  end

  private

  def set_album
    @album = Album.find(params[:id])
  end

  def album_params
    params.require(:album).permit(:title, :description, :sharing_mode, album_images: [])
  end
end
