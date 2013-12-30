module PublishingConcern

  extend ActiveSupport::Concern

  def set_publishing_bit
    self.publishing_bit = true
  end

  def publishing_bit_on?
    publishing_bit.present?
  end

  
end
