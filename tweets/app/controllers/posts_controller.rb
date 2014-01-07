class PostsController < ApplicationController
  before_action :set_user_post, only: [:clone]

 #FIXME_AB: Why I am not allowed to see public timeline if I am not logged in?
  def index
    #FIXME_AB: including_associations for eager loading is not readable
    @tweets = Tweet.order(created_at: :desc).including_associations
  end
  
  def create
    @post = Post.new(post_params) 
    if(@post.save)
      flash[:notice] = "Post was successfully created"
    else
      #FIXME_AB: So now when the tweet is not saved due to whatever reason, I have to re-type every thing. Why?
      flash[:alert] = "Post could not be saved because "  + @post.errors.full_messages.join(" ,")
    end
    redirect_to_back_or_default_url 
  end

  #FIXME_AB: I would have named this action as retweet
  def clone
    @tweet.retweet
    redirect_to_back_or_default_url
  end


  private

  def set_user_post
    @post = Post.find_by(id: params[:id])
    redirect_to_back_or_default_url if @post.nil?
    #FIXME_AB: Why can't I eager laod tweet
    @tweet = @post.tweets.find_by(id: params[:tweet_id]) if !@post.nil?
  end


  def post_params
    params.require(:post).permit(:content)
  end
end
