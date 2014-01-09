class PostsController < ApplicationController
  before_action :set_user_post, only: [:retweet]
  skip_before_action :authorize, only: [:index]
  before_action :set_tags, only: [:create]

 #FIXME_AB: Why I am not allowed to see public timeline if I am not logged in?
 #fixed
  def index
    #FIXME_AB: including_associations for eager loading is not readable
    #fixed
    @tweets = Tweet.order(created_at: :desc).eager_loading_associations
  end

  def edit
  end

  def create
    @post = current_user.posts.create(post_params)
    if(@post.persisted?)
      flash[:notice] = "Post was successfully created"
      redirect_to user_path(current_user.username)
    else
      #FIXME_AB: So now when the tweet is not saved due to whatever reason, I have to re-type every thing. Why?
      #fixed
      flash[:alert] = "Post could not be saved because "  + @post.errors.full_messages.join(" ,")
      render action: 'edit'
    end
    
  end

  def hash_tags
    @tweets = Tweet.by_hash_tag(params[:hash_tag])
    render action: 'index'
  end

  def user_tags
    @tweets = Tweet.with_tags(current_user)
    render action: 'index'
  end

  
  #FIXME_AB: I would have named this action as retweet
  #fixed
  def retweet
    @tweet.retweet(current_user)
    redirect_to_back_or_default_url
  end


  private

  def set_user_post
    @tweet = Tweet.find_by(id: params[:id])
    redirect_to_back_or_default_url if @tweet.nil?
  end

  def set_tags
    params[:post][:content].gsub!(/@\w+/i) do |tag| 
      tagged_user = User.find_by(username: tag.split('@')[1])
      user_id = tagged_user.nil? ? "" : tagged_user.id
      params[:post][:tags] += " " + user_id.to_s + " "
      tag.delete! '@'
      
    end
  end


  def post_params
    params.require(:post).permit(:content, :tags)
  end
end
