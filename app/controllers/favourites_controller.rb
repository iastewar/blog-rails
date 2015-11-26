class FavouritesController < ApplicationController
  before_action :authenticate_user

  def create
    @fav          = current_user.favourites.new
    @p     = Post.find params[:post_id]
    redirect_to post_path(@p), alert: "Access denied." and return if can? :manage, @p
    @fav.post = @p
    respond_to do |format|
      if @fav.save
        format.html { redirect_to post_path(@p), notice: "Favourited!" }
        format.js { render :create_success }
      else
        format.html { redirect_to post_path(@p), alert: "Error occured!" }
      end
    end
  end

  def destroy
    @p = Post.find params[:post_id]
    redirect_to post_path(@p), alert: "Access denied." and return if can? :manage, @p
    @fav      = current_user.favourites.find params[:id]
    @fav.destroy
    respond_to do |format|
      format.html { redirect_to post_path(@p), notice: "Unfavourited!" }
      format.js { render }
    end
  end

  def index
    @favourites = current_user.favourites
  end

end
