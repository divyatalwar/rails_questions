class Product < ActiveRecord::Base
  include PublishingConcern
  
  belongs_to :offer, inverse_of: :products
  validate :publishing_requirements,  if: :publishing_bit_on?, :on => :update
  before_create :set_publishing_bit


  
  def publishing_requirements
    if quantity.nil?
      errors.add("products" + self.id.to_s, "quantity cannot be zero")
      self.offer.event.errors.add("products" + self.id.to_s, "quantity cannot be zero") 
      return false
    end
  end

  def publishable
    update_attributes({:published => true})
  end

end
