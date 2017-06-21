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

Factory.define :resume do |resume|
  resume.url    "trivektor"
  resume.title  "Tri Vuong's resume"
  
  #resume.association :resume_educations, :factory => :resume_education
  resume.resume_educations { |resume| [resume.association(:resume_education)] }
  resume.resume_section_orders { |resume| [resume.association(:resume_section_order)] }
end

Factory.define :resume_education do |e|
  e.institution     "University of Toronto"
  e.begin_date      "Sep 2004"
  e.end_date        "Dec 2008"
  e.degree          "Honours Bachelor of Science"
  e.field_of_study  "Computer Science"
  e.status          "active"
end

Factory.define :resume_section_order do |o|
  o.section "personal_information"
  o.name "Personal Information"
end