namespace :email_comment_summary do

  desc "Generate a summary of all comments created today for each post owner and email it to them"
  task gen_email_comment_summary: :environment do
    all_comments_today = Comment.where("created_at >= ?", 1.day.ago)
    CommentsMailer.comment_summary(all_comments_today, User.all).deliver_now
  end


end
