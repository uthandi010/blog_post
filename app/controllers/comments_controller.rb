class CommentsController < ApplicationController
  before_action :require_login
  before_action :set_blog_post
  before_action :set_comment, only: [ :edit, :update, :destroy, :reply ]
  before_action :authorize_comment_owner, only: [ :edit, :update, :destroy ]

  def create
    @comment = @blog_post.comments.new(comment_params)
    @comment.user = current_user

    if @comment.save
      redirect_to @blog_post, notice: "Comment added successfully!"
    else
      redirect_to @blog_post, alert: "Failed to add comment."
    end
  end


  def edit
    @comment = Comment.find(params[:id])
  end


  def update
    if @comment.update(comment_params)
      redirect_to @blog_post, notice: "Comment updated successfully!"
    else
      render :edit, alert: "Failed to update comment."
    end
  end

  def destroy
    @comment.destroy
    redirect_to @blog_post, notice: "Comment deleted successfully!"
  end

  def reply
    @reply = @blog_post.comments.new(parent_id: @comment.id)
  end

  private

  def set_blog_post
    @blog_post = BlogPost.find(params[:blog_post_id])
  end

  def set_comment
    @comment = @blog_post.comments.find(params[:id])
  end

  def authorize_comment_owner
    unless @comment.user == current_user
      redirect_to @blog_post, alert: "You are not authorized to perform this action."
    end
  end

  def comment_params
    params.require(:comment).permit(:content, :parent_id)
  end
end
