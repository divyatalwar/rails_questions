require_relative '../spec_helper'

describe FollowingsController do
  login_user
  before :each do   
    request.env["HTTP_REFERER"] =  'http://test.host/users/divya'
    controller.stub(:authorize).and_return(true)
  end


  describe 'Post Create' do
    before do 
      @user = FactoryGirl.create(:user, email: "abcd@vinsol.com", firstname: "abcd", lastname: "defs", username: "username")
      @following = FactoryGirl.create(:following, followee_id: @user.id)
    end
    it 'user should call save' do
      Following.any_instance.should_receive(:save).and_return(@following)
      post :create , {following: FactoryGirl.attributes_for(:following), followee_id: @user.id}
    end

    context 'when saved' do
      before do
        post :create , {following: FactoryGirl.attributes_for(:following), followee_id: @user.id}
      end

      it 'should redirect to back' do
      
        response.should redirect_to request.env["HTTP_REFERER"]
      end
    end
  end

  describe "Following Destroy" do
    before do
      @user = FactoryGirl.create(:user, email: "abcde@vinsol.com", firstname: "abcde", lastname: "defs", username: "username")
      @following = FactoryGirl.create(:following, followee_id: @user.id)
    end
    context "when following is found" do
      before do
        Following.stub(:find_by).with(followee_id: "#{@following.id}").and_return(@following)
      end
      
      it "should call destroy" do
        @following.stub(:destroy).and_return(@following) 
        delete :destroy, id: @following.id, followee_id: @user.id
      end

      context 'when successfully destroyed' do
        before do
          delete :destroy, id: @following.id, followee_id: @user.id
        end

        it 'should redirect to back' do
          response.should redirect_to request.env["HTTP_REFERER"]
        end
      end
      context 'when not Destroyed' do
        before do
          @following.stub(:destroy).and_return(false)
          delete :destroy, id: @following.id
        end

        it 'should redirect' do
          response.should redirect_to request.env["HTTP_REFERER"]
        end
        it 'should have errors' do
          @following.errors.count > 1
        end
      end
    end
  end
end