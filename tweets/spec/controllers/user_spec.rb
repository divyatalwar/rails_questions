require_relative '../spec_helper'

describe UsersController do
  login_user
  before :each do   
    request.env["HTTP_REFERER"] =  'http://test.host/'
    controller.stub(:authorize).and_return(true)
  end

  describe "GET Index" do
    before do
      @user = FactoryGirl.create(:user, email: "abcd@vinsol.com", firstname: "abc",lastname: "cde", username: "sfdsf")
    end

    it "assigns @users" do
      get :index
      expect(assigns(:users).first).to eq @user
    end
    it "should render index template" do
      get :index
      expect(response).to render_template :index
    end
  end
  describe 'Get Show' do
    before do
      @user = FactoryGirl.create(:user,email: "abcefg@vinsol.com", firstname: "abc",lastname: "cde", username: "abcdefgs")
    end

    context "when User is found with Id" do
      before do
       get :show, id: @user.username
      end
      it "should assign @user" do
        expect(assigns(:user)).to eq(@user)
      end
      it "should render show template" do
        response.should render_template :show
      end
      it "has a 200 status code" do
        expect(response.status).to eq(200)
      end
    end
    context "when User in not found with Id" do
      before do
        @user.username = ""
        get :show, id: @user.username
      end
      it "should redirect Users Index" do
        response.should redirect_to request.env["HTTP_REFERER"]
      end
      it "has a 302 status code" do
        expect(response.status).to eq(302)
      end
    end
  end

  describe 'get user timeline' do
   before do
      @user = FactoryGirl.create(:user, email: "abcde@vinsol.com", firstname: "abc",lastname: "cde", username: "abcdef")
      @user.stub(:timeline).and_return(@tweets)
    end

    it "assigns @users" do
      get :timeline, id: @user.username
      
    end
    it "should render timeline template" do
      get :timeline, id: @user.username
      expect(response).to render_template :timeline
    end
  end

  describe 'get autocomplete_suggestions'  do
      before do
        @user = FactoryGirl.create(:user, email: "abcde@vinsol.com", firstname: "abc",lastname: "cde", username: "abcdef")
        get :autocomplete_suggestions
        User.stub(:get_autocomplete_suggestions).and_return(@user)
        #
      end

      it "should render json content" do
        
        @account.should_not render_template("new")
      end
    end

  describe "Post change privacy" do
    before do
      @user = FactoryGirl.create(:user, email: "abcde@vinsol.com", firstname: "abc",lastname: "cde", username: "abcdef")
    end
    context "when user is found" do
      before do
       # Post.stub(:find_by).with(id: "#{@post.id}").and_return(@post)
       User.stub(:find_by).with(username: "#{@user.username}").and_return(@user)
      end
      
      it "should call update privacy" do
        @user.stub(:update_privacy).and_return(@user)
         get :change_privacy , { id: @user.username}
      end
      context 'when change is successful' do
        before do
          get :change_privacy , { id: @user.username}    
        end
        it 'should redirect to back' do
          response.should redirect_to request.env["HTTP_REFERER"]
        end
      end
    end
  end

   describe 'get user followers' do
   before do
      @user = FactoryGirl.create(:user, email: "abcde@vinsol.com", firstname: "abc",lastname: "cde", username: "abcdef")
      @user.stub(:followers).and_return(@users)
    end

    it "assigns @users" do
      get :followers, id: @user.username
      
    end
    it "should render index template" do
      get :followers, id: @user.username
      expect(response).to render_template :index
    end
  end

  describe 'get user followees' do
    before do
      @user = FactoryGirl.create(:user, email: "abcde@vinsol.com", firstname: "abc",lastname: "cde", username: "abcdef")
      @user.stub(:followers).and_return(@users)
    end

    it "assigns @users" do
      get :followees, id: @user.username
      
    end
    it "should render index template" do
      get :followees, id: @user.username
      expect(response).to render_template :index
    end
  end


end