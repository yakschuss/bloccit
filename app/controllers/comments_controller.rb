class CommentsController < ApplicationController
  before_action :require_sign_in
  before_action :authorize_user, only: [:destroy]
  before_action :ready_post

  def create
#    @post = Post.find(params[:post_id])
    comment = @post.comments.new(comment_params)
    comment.user = current_user

    if comment.save
      flash[:notice] = "Comment saved"
      redirect_to [@post.topic, @post]
    else
      flash[:error] = "Comment failed to save."
      redirect_to [@post.topic, @post]
    end
  end

  def destroy
#    @post = Post.find(params[:post_id])
    comment = @post.comments.find(params[:id])

    if comment.destroy
      flash[:notice] = "Comment Deleted"
      redirect_to [@post.topic, @post]
    else
      flash[:error] = "Woops, comment wasn't deleted. try again."
      redirect_to [@post.topic, @post]
    end
  end



private


  def ready_post
    @post = Post.find(params[:post_id])
  end

  def comment_params
    params.require(:comment).permit(:body,)
  end

  def authorize_user
    comment = Comment.find(params[:id])
    unless current_user = comment.user || current_user.admin?
      flash[:error] = "You do not have permission to delete that comment."
      redirect_to [comment.post.topic, comment.post]
    end
  end

end
