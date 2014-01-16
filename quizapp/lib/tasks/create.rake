namespace :admin do
  desc "To create an admin"
  task :create => :environment do 
    print "Enter user name: "
    username = $stdin.gets.chomp
    print "Enter email: "
    email= $stdin.gets.chomp
    print "Enter password(minimum 8 characters) "
    password = $stdin.gets.chomp
    admin = User.new(:username => username, :email => email, :user_type => "admin", :password => password)
    admin.save!
    puts "Admin created"
  end
end
