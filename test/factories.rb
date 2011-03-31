Factory.define :user do |user|
  user.first_name "Tri"
  user.last_name  "Vuong"
  user.username   "trivektor"
  user.email      "trivektor@gmail.com"
  user.password   "abcd"
  user.active     true
  
  user.association :profile, :factory => :profile
end

Factory.define :profile do |profile|
  profile.first_name "Tri"
  profile.last_name "Vuong"
end