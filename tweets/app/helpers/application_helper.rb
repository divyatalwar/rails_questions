module ApplicationHelper

  def get_users(tags)
    tag = tags.split()
    User.where(id: tag)
  end
end