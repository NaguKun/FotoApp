class HomeController < ApplicationController
    def show
      @photos = Photo.all
      @albums = Album.all
    end
end