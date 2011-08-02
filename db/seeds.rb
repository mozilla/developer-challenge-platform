# Admin Users

admins = [
  'moomerman@gmail.com'
]
admins.each do |x| 
  user = User.new(:email => x, :password => SecureRandom.urlsafe_base64)
  user.admin = true
  user.save!
end

# Levels

levels = [
  'Beginner / Low', 'Intermediate / Medium', 'Advanced / High'
]
levels.each{|x| Level.create!(:name => x)}

# Categories

categories = [
  'QA/Testing/Automation', 'Metrics/Analytics', 'Add-ons/Extensions', 'Privacy & Identity',
  'Social & Contacts', 'Web Developer Tools', 'Infographics/Data Visualisation', 'Documentation',
  'Security', 'Payments', 'Web Apps', 'SysAdmin/Site Ops', 'Accessibility', 'Research',
  'Gaming', 'Video', 'Audio', 'Animation', 'Messaging/Communication/Email', 'Education/Learning',
  'Storage', 'Other'
]
categories.each{|x| Category.create!(:name => x)}

# Platfmorms

platforms = [
  'Mobile/Tablet', 'Desktop', 'Other'
]
platforms.each{|x| Platform.create!(:name => x)}

# Languages

languages = [
  'C++', 'Java', 'VB.net', 'C#', 'Python', 'Ruby', 'Other'
]
languages.each{|x| Language.create!(:name => x)}

# Durations

durations = [
  ['1 week', 1.week], ['2 weeks', 2.weeks], ['3 weeks', 3.weeks], ['1 month', 1.month], ['2 months', 2.months]
]
durations.each{|x, y| Duration.create!(:name => x, :duration => y)}

# Reviewers
10.times do |i| 
  user = User.new(:email => "reviewer#{i}@mozdevchallenge.org", :password => 'reviewer')
  user.reviewer = true
  user.save!
  Profile.create!(:user => user, :username => "reviewer#{i}", :name => "Reviewer #{i}")
end

# Judges
10.times do |i| 
  user = User.new(:email => "judge#{i}@mozdevchallenge.org", :password => 'judge')
  user.judge = true
  user.save!
  Profile.create!(:user => user, :username => "judge#{i}", :name => "Judge #{i}")
end