class Event < ActiveRecord::Base
  include PublishingConcern
  has_many :offers, inverse_of: :event
  validates :start, :end, :presence => true, on: :create
  validate :publishable_requirements,  if: :publishing_bit_on?, :on => :update
  before_create :set_publishing_bit

    
  def publishing_requirements
    if self.end - self.start < 1.day
      errors.add(:event, "difference between start and end date should be more than a day")
      return false
    end
  end


  def publishable
    offers.each do |offer|
      if !offer.publishable
        return false
      end
    end
    update_attributes({:published => true})
  end

end
