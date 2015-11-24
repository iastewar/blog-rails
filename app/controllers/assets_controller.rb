class AssetsController < ApplicationController
  before_action :authenticate_user, only: [:create, :destroy]

  def create
    asset_params = params.require(:asset).permit(:file)
    @p = Post.find params[:post_id]
    @asset = Asset.new asset_params
    @asset.post = @p

    if @asset.save
      redirect_to post_path(@p), notice: "Asset created succussfully!"
    else
      @assets = @p.assets.order(created_at: :desc)
      render "posts/show"
    end
  end

  def destroy
    asset = Asset.find_by_id params[:id]
    if asset
      redirect_to post_path(params[:post_id]), alert: "Access denied." and return unless can? :destroy, asset
      asset.destroy
      redirect_to post_path(asset.post), notice: "Asset deleted"
    else
      redirect_to post_path(params[:post_id]), notice: "Asset already deleted"
    end

  end
end
