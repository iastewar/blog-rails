class CommentsController < ApplicationController
  before_action :authenticate_user, only: [:create, :destroy]

  def create
    comment_params = params.require(:comment).permit(:body)
    @p = Post.find params[:post_id]
    @comment = Comment.new comment_params
    @comment.post = @p
    @comment.user = current_user

    if @comment.save
      CommentsMailer.notify_post_owner(@comment).deliver_later
      redirect_to post_path(@p), notice: "Comment created succussfully!"
    else
      @comments = @p.comments.order(created_at: :desc)
      render "posts/show"
    end
  end

  def destroy
    comment = Comment.find_by_id params[:id]
    if comment
      redirect_to post_path(params[:post_id]), alert: "Access denied." and return unless can? :destroy, comment
      comment.destroy
      redirect_to post_path(comment.post), notice: "Comment deleted"
    else
      redirect_to post_path(params[:post_id]), notice: "Comment already deleted"
    end

  end

end
