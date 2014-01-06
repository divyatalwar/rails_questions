module UserConcern

  extend ActiveSupport::Concern
  
  def current_user
    Thread.current[:user]
  end
  
end