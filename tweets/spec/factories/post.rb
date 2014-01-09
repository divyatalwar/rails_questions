require 'factory_girl'

FactoryGirl.define do
  factory :post do
    content "abcdef"
    tags " 1 2 "
  end
end