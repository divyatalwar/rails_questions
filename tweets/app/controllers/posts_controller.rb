class PostsController < ApplicationController
  before_action :set_post, only: [:show, :clone, :edit, :update, :destroy]

 
  def index
    @posts = Post.all
    render :template => "posts/_posts", locals: { :posts => @posts}
  end

  def show
  end

  def new
    @post = Post.new
  end
 def edit
  end

  def create
   @post = current_user.posts.build(post_params) 

    if(@post.save)
      respond_to do |format|
        format.html do 
          flash[:notice] = "post was successfully created"
          redirect_to_back_or_default_url 
        end
      end
    else
      respond_to do |format|
        format.html do 
          flash[:alert] = "Could not be saved becuase there was no content in it"
          redirect_to_back_or_default_url 
        end
      end
    end
  end

  def clone
    @post.clone_post(current_user)
    redirect_to_back_or_default_url
  end


  private
    # Use callbacks to share common setup or constraints between actions.
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
