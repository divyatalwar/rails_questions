module UsersHelper
  def get_user(id)
    User.find_by(firstname: id)
  end
end
