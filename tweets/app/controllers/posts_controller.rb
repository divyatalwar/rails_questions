class PostsController < ApplicationController
  before_action :set_post, only: [:show, :clone]

 
  def index
    @posts = Post.order("created_at desc").all
    render :template => "posts/_posts", locals: { :posts => @posts }
  end

  

  def new
    @post = Post.new
  end

  
  def create
   @post = current_user.posts.build(post_params) 

    if(@post.save)
      flash[:notice] = "post was successfully created"
    else
      flash[:alert] = "Could not be saved"
    end
    redirect_to_back_or_default_url 
  end

  def clone
    @post.clone_post(current_user)
    redirect_to_back_or_default_url
  end


  private

  def set_post
    @post = Post.find_by(id: params[:id])
    if(@post.nil?)
      flash[:alert] = "Post not found"
      redirect_to_back_or_default_url 
    end
  end


  def post_params
    params.require(:post).permit(:content)
  end
end
