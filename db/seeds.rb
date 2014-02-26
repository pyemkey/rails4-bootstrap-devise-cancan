puts 'ROLES'
YAML.load(ENV['ROLES']).each do |role|
  Role.where({ :name => role }, :without_protection => true).first_or_create
  puts 'role: ' << role
end
puts 'DEFAULT USERS'
user = User.create :name => ENV['ADMIN_NAME'].dup, :email => ENV['ADMIN_EMAIL'].dup, :password => ENV['ADMIN_PASSWORD'].dup, :password_confirmation => ENV['ADMIN_PASSWORD'].dup
puts 'user: ' << user.name
user.add_role :admin
user2 = User.create :name => 'Second User', :email => 'user2@example.com', :password => 'changeme', :password_confirmation => 'changeme'
puts 'user: ' << user2.name
user2.add_role :VIP