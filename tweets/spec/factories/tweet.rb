require 'factory_girl'

FactoryGirl.define do
  factory :tweet do
    post_id { Post.find_by(content: "abcdef").id}
    user_id {User.find_by(email: "divya@vinsol.com").id}
    retweeted false
    retweeted_from nil
  end
end