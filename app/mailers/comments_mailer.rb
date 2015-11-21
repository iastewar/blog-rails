class CommentsMailer < ApplicationMailer
  def notify_post_owner(comment)
    @comment   = comment
    @post = comment.post
    @owner    = @post.user
    if @owner == comment.user
      return
    end
    if @owner.email.present?
      mail(to: @owner.email, subject: "You got a new comment!")
    end
  end

  def comment_summary(all_comments_today, users)
    @all_comments_today = all_comments_today

    users.each do |owner|
      next unless owner.posts.present?
      @owner = owner
      mail(to: @owner.email, subject: "Today's Comment List")
    end
  end
end
