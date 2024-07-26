# app/controllers/reactions_controller.rb
class ReactionsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_photo

  def create
    @reaction = @photo.reactions.new(user: current_user)

    if @reaction.save
      redirect_to root_path, notice: 'Photo liked successfully.'
    else
      redirect_to root_path, alert: 'Unable to like photo.'
    end
  end

  def destroy
    @reaction = @photo.reactions.find_by(user: current_user)
    
    if @reaction&.destroy
      redirect_to root_path, notice: 'Like removed successfully.'
    else
      redirect_to root_path, alert: 'Unable to remove like.'
    end
  end

  private

  def set_photo
    @photo = Photo.find(params[:photo_id])
  end
end