class BlogPostsController < ApplicationController
  before_action :set_blog_post, only: %i[show edit update destroy]
  load_and_authorize_resource # the association is to control the ability

  def index
    @blog_posts.includes(:user) # blogpost table all values to combian to users //
  end

  def new
    @blog_post = BlogPost.new # it is create the empty blogpost with current user_id
  end

  def create
    @blog_post = current_user.blog_posts.new(blog_post_params) # the input post value is get same as user_id // the new key word is stored in the new post on the blogpost table //
    if @blog_post.save # blogpost created to stored at blogpost table check it will true execute the block //
      redirect_to blog_post_path(@blog_post) # it is redirect to the another page with blogpost_id // it is use to show the post with the blogpost_id //
      flash[:notice] = 'Blog post created successfully!' # it is the flash message...//
    else
      flash[:alert] = 'Failed to create blog post.'
      render :new
    end
  end

  def show
  end

  def edit
  end

  def update
    if @blog_post.update(blog_post_params) # it will update all the value from the blogpost table
      redirect_to blog_post_path(@blog_post) # it is redirect to the another page with blogpost_id // it is use to show the post with the blogpost_id
    else
      error_message = @blog_post.errors[:picture].first
      @blog_post = BlogPost.find(@blog_post.id)
      @blog_post.errors.add(:picture, error_message)
      render :edit
    end
  end

  def destroy
    @blog_post.destroy # it will destroy the blogpost on the blogpost table
    redirect_to blog_posts_path # it will redirect to the blogpost index path
  end

  private

  def blog_post_params
    params.require(:blog_post).permit(:description, :picture) # it is allow the permit values like key and value are hash function //
  end

  def set_blog_post
    @blog_post = BlogPost.find(params[:id]) # it will returen the blogpost_id to execute the show,edit,update,destroy. //
  rescue ActiveRecord::RecordNotFound
    redirect_to blog_posts_path
  end
end
