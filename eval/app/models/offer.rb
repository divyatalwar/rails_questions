class Offer < ActiveRecord::Base
  include PublishingConcern
  belongs_to :event, inverse_of: :offers
  has_many :products, inverse_of: :offer
  validates :discount, presence:  true, on: :create
  validate :publishing_requirements,  if: :publishing_bit_on?, :on => :update
  before_create :set_publishing_bit


  def publishing_requirements
    if discount < 2
      self.event.errors.add("offer" + self.id.to_s, "discount shoulld be more than 2%")
      errors.add("offer" + self.id.to_s, "discount shoulld be more than 2%")
      return false
    end 
  end

  def publishable
    products.each do |product|
      if !product.publishable
        return false
      end
    end
    update_attributes({:published => true})
  end
end
