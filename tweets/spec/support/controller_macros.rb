module ControllerMacros
   def login_user
    before(:each) do
      @request.env["devise.mapping"] = Devise.mappings[:user]
      @user = FactoryGirl.create(:user, email: "abc@vinsol.com", firstname: "myname", lastname: "mylastname", username: "myusername")
      sign_in @user
    end
  end
end