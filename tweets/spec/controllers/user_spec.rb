require_relative '../spec_helper'

describe UsersController do
  login_user
  before :each do   
    request.env["HTTP_REFERER"] =  'http://test.host/'
    controller.stub(:authorize).and_return(true)
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
end