class FavouritesController < ApplicationController
  before_action :authenticate_user

  def create
    fav          = current_user.favourites.new
    post     = Post.find params[:post_id]
    redirect_to project_path(post), alert: "Access denied." and return if can? :manage, post
    # fav.user     = current_user
    fav.post = post
    if fav.save
      redirect_to post_path(post), notice: "Favourited!"
    else
      redirect_to post_path(post), alert: "Error occured!"
    end
  end

  def destroy
    post = Post.find params[:post_id]
    redirect_to project_path(post), alert: "Access denied." and return if can? :manage, post
    fav      = current_user.favourites.find params[:id]
    fav.destroy
    redirect_to post_path(post), notice: "Unfavourited!"
  end

  def index
    @favourites = current_user.favourites
  end

end
