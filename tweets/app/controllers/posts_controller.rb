class PostsController < ApplicationController
  before_action :set_user_post, only: [:clone]

 
  def index
    @posts = UserPost.order("created_at desc").all
    render :template => "posts/_posts", locals: { :posts => @posts }
  end

  

  def new
    @post = Post.new
  end

  
  def create
   @post = Post.new(post_params) 
   @user_post = @post.user_posts.build({ user_id: current_user.id })

    if(@post.save)
      flash[:notice] = "post was successfully created"
    else
      flash[:alert] = "Could not be saved"
    end
    redirect_to_back_or_default_url 
  end

  def clone
    @userpost.clone_post(current_user)
    redirect_to_back_or_default_url
  end


  private

  def set_user_post
    @post = Post.find_by(id: params[:id])
    @userpost = @post.user_posts.find_by(id: params[:user_post_id]) if !@post.nil?
  end


  def post_params
    params.require(:post).permit(:content)
  end
end
