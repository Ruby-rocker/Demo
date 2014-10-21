# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)


puts '*****************Creating Push notification configuration*****************'

ActiveRecord::Base.connection.execute "truncate push_configurations"

if Rails.env == "development"
  Push::ConfigurationApns.create(app: 'pushtest', connections: 2, enabled: true,
                                 certificate: File.read('/home/mehul/Gagan/Projects/iBeacon/config/ck.pem'),
                                 feedback_poll: 5,
                                 sandbox: true)

else
  Push::ConfigurationApns.create(app: 'pushtest', connections: 2, enabled: true,
                                 certificate: File.read('/home/ror/iBeacon/config/ck.pem'),
                                 feedback_poll: 5,
                                 sandbox: true)
end

Push::ConfigurationGcm.create(app: '664035732246', connections: 2, enabled: true,
                              key: 'AIzaSyDOemdQWyLkw9BBMZ2A0zAsEvMFuJEydec')

puts '*****************Push notification configuration generated*****************'
puts 'Creating Admin.....'

ActiveRecord::Base.connection.execute "truncate admins"

Admin.create!({:username => 'admin', :email => 'admin@admin.com', :admin_type => 'super admin', :password => 'admin123', :password_confirmation => 'admin123', :is_active => true })

puts 'Admin Created'

puts 'Creating Titles.....'

ActiveRecord::Base.connection.execute "truncate titles"

Title.create!({:name => 'Mr.'})
Title.create!({:name => 'Mrs.'})
Title.create!({:name => 'Miss'})

puts 'Titles Created'

puts 'Creating Access Modules.....'

ActiveRecord::Base.connection.execute "truncate access_modules"

AccessModule.create!({:name => 'Campaign', :is_active => true})
AccessModule.create!({:name => 'Beacon', :is_active => true})
AccessModule.create!({:name => 'Template', :is_active => true})

puts 'Access Modules Created'

ActiveRecord::Base.connection.execute "truncate beacon_ranges"

BeaconRange.create!({:name => 'Immediate (5 Meters)', :range => "5", :is_active => true})
BeaconRange.create!({:name => 'Near (20 meters)', :range => "20", :is_active => true})
BeaconRange.create!({:name => 'Far (30 meters)', :range => "30", :is_active => true})

puts 'Beacon Ranges Created'
