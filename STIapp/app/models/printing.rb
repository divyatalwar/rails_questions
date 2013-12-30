class Printing < Device
  #has_many :comments ,  as: :commentable
	validate  :at_least_one_checked

	def at_least_one_checked
		if inkjet.blank? && laser.blank?
			errors.add(:printing, "You must select at least one option.")
		end
	end
end
