class Network < Device
  #has_many :comments ,  as: :commentable
  validate  :at_least_one_checked
  def at_least_one_checked
  	if ethernet.blank? && wifi.blank?
  		errors.add(:network, "You must select at least one option.")
  	end
  end
end