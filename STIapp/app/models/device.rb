class Device < ActiveRecord::Base
  has_many :comments ,  as: :commentable
  validates :name, :type, presence: true
end
