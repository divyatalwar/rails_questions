require 'factory_girl'

FactoryGirl.define do
  factory :user do
    email "divya@vinsol.com"
    firstname "divya"
    lastname "talwar"
    username "divyatalwar"
    password "dffdsgfds"
  end
end