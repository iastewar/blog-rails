class CommentsController < ApplicationController
  before_action :authenticate_user, only: [:create, :destroy, :edit, :update]

  def create
    comment_params = params.require(:comment).permit(:body)
    @p = Post.find params[:post_id]
    @comment = Comment.new comment_params
    @comment.post = @p
    @comment.user = current_user

    respond_to do |format|
      if @comment.save
        CommentsMailer.notify_post_owner(@comment).deliver_later
        format.html { redirect_to post_path(@p), notice: "Comment created succussfully!" }
        format.js { render :create_success }
      else
        @comments = @p.comments.order(created_at: :desc)
        @assets = @p.assets.order(created_at: :desc)
        format.html { render "posts/show" }
        format.js { render :create_failure }
      end
    end
  end

  def edit
    @p = Post.find_by_id params[:post_id]
    @comment = Comment.find_by_id params[:id]
    respond_to do |format|
      format.html { redirect_to post_path(@p), alert: "Access denied." and return unless can? :edit, @comment }
      format.js { render }
    end
  end

  def update
    comment_params = params.require(:comment).permit(:body)
    @p = Post.find params[:post_id]
    @comment = Comment.find params[:id]
    respond_to do |format|
      if @comment.update(comment_params)
        format.html { redirect_to post_path(@p), notice: "Question updated!" }
        format.js { render :update_success }
      else
        @comments = @p.comments.order(created_at: :desc)
        @assets = @p.assets.order(created_at: :desc)
        format.html { render "posts/show" }
        format.js { render :update_failure }
      end
    end
  end

  def destroy
    @comment = Comment.find_by_id params[:id]
    respond_to do |format|
      if @comment
        format.html { redirect_to post_path(params[:post_id]), alert: "Access denied." and return unless can? :destroy, @comment }
        @comment.destroy
        format.html { redirect_to post_path(comment.post), notice: "Comment deleted" }
        format.js { render }
      else
        format.html { redirect_to post_path(params[:post_id]), notice: "Comment already deleted" }
      end
    end
  end

end
