class PostsController < ApplicationController
  before_action :find_post, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user, only: [:new, :create, :edit, :update, :destroy]

  def new
    @p = Post.new
  end

  def create
    @p = Post.new(post_params)
    @p.user = current_user
    if @p.save
      redirect_to(post_path(@p), notice: "Post created!")
    else
      render :new
    end
  end

  def show
    @comments = @p.comments.order(created_at: :desc)
    @comment = Comment.new

    @assets = @p.assets.order(created_at: :desc)
    @asset = Asset.new

  end

  def edit
    redirect_to post_path(@p), alert: "Access denied." and return unless can? :edit, @p
  end

  def update
    redirect_to post_path(@p), alert: "Access denied." and return unless can? :update, @p
    if @p.update post_params
      redirect_to(post_path(@p))
    else
      render :edit
    end
  end

  def index
    @posts = Post.order(updated_at: :desc)
  end

  def destroy
    redirect_to post_path(@p), alert: "Access denied." and return unless can? :destroy, @p
    @p.destroy
    flash[:notice] = "Post deleted successfully"
    redirect_to posts_path
  end

  private

  def post_params
    params.require(:post).permit([:title, :body, {tag_ids: []}])
  end

  def find_post
    @p = Post.find(params[:id])
  end
end
