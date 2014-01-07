class PostsController < ApplicationController
  before_action :set_user_post, only: [:clone]

 
  def index
    @tweets = Tweet.order(created_at: :desc).including_associations
  end

  
  def create
    @post = Post.new(post_params) 
    if(@post.save)
      flash[:notice] = "Post was successfully created"
    else
      flash[:alert] = "Post could not be saved because "  + @post.errors.full_messages.join(" ,")
    end
    redirect_to_back_or_default_url 
  end

  def clone
    @tweet.retweet
    redirect_to_back_or_default_url
  end


  private

  def set_user_post
    @post = Post.find_by(id: params[:id])
    redirect_to_back_or_default_url if @post.nil?
    @tweet = @post.tweets.find_by(id: params[:tweet_id]) if !@post.nil?
  end


  def post_params
    params.require(:post).permit(:content)
  end
end
