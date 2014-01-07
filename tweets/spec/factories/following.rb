require 'factory_girl'

FactoryGirl.define do
  factory :following do
    followee_id { User.find_by_email("divya@vinsol.com").id }
    user_id { User.find_by_email("divya@vinsol.com").id }
  end
end