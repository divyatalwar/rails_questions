require_relative '../spec_helper'

describe PostsController do
  login_user
  before :each do   
    request.env["HTTP_REFERER"] =  'http://test.host/users/divyatalwar'
    controller.stub(:authorize).and_return(true)
  end
  describe "GET Index" do
    before do
      @post = FactoryGirl.create(:post)
      @tweet =  FactoryGirl.create(:tweet, post_id: @post.id)
    end
    it "assigns @tweets" do
      get :index
      expect(assigns(:tweets).first).to eq @tweet
    end
    it "should render index template" do
      get :index
      expect(response).to render_template :index
    end
  end

  describe 'Post Create' do
    before do 
      @post = FactoryGirl.create(:post)
      @tweet =  FactoryGirl.create(:tweet, post_id: @post.id)
    end
    it 'user should call save' do
      Post.should_receive(:new).and_return(@post)
      @post.should_receive(:persisted?).and_return(true)
      post :create , {post: FactoryGirl.attributes_for(:post)}
    end

    context 'when saved' do
      before do
        post :create , {post: FactoryGirl.attributes_for(:post)}
      end

      it 'should redirect to back' do
        response.should redirect_to request.env["HTTP_REFERER"]
      end
    end

    context 'when not saved' do
      before do
          post :create , {post: {content: ""} }
      end

      it 'should render edit template' do
        response.should render_template 'edit'
      end
    end
  end

   describe "Post retweet" do
    before do
      @post = FactoryGirl.create(:post)
      @tweet =  FactoryGirl.create(:tweet, post_id: @post.id)
    end
    context "when voucher is found" do
      before do
       # Post.stub(:find_by).with(id: "#{@post.id}").and_return(@post)
       Tweet.stub(:find_by).with(id: "#{@tweet.id}").and_return(@tweet)
      end
      
      it "should call clone" do
        @tweet.stub(:retweet).and_return(@tweet)
         get :retweet , { id: @tweet.id}
      end
      context 'when change is successful' do
        before do
          get :retweet , { id: @tweet.id}    
        end
        it 'should redirect to back' do
          response.should redirect_to request.env["HTTP_REFERER"]
        end
      end
    end
  end

  describe 'get post hash tags' do
   before do
      @post = FactoryGirl.create(:post)
      @tweet = FactoryGirl.create(:tweet, post_id: @post.id)
      Tweet.stub(:by_hash_tag).and_return(@tweet)
    end

    it "gets hash tags request" do
      get :hash_tags, hash_tag: "abc"
      
    end
    it "should render index template" do
      get :hash_tags, hash_tag: "abc"
      expect(response).to render_template :index
    end
  end

  describe 'get post user tags' do
   before do
      @user = FactoryGirl.create(:user, email: "abcd@vinsol.com", firstname: "abc", lastname: "def", username:"abcdef")
      @post = FactoryGirl.create(:post)
      @tweet = FactoryGirl.create(:tweet, post_id: @post.id)
      Tweet.stub(:by_user_tag).and_return(@tweet)
    end

    it "gets user tags request" do
      get :user_tags, id: @user.username
      
    end
    it "should render index template" do
      get :user_tags, id: @user.username
      expect(response).to render_template :index
    end
  end

end