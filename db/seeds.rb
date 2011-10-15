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

# Admins
10.times do |i| 
  user = User.new(:email => "admin#{i}@mozdevchallenge.org", :password => 'admin')
  user.admin = true
  user.save!
  Profile.create!(:user => user, :username => "admin#{i}", :name => "Admin #{i}")
end

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

# Users
10.times do |i| 
  user = User.new(:email => "user#{i}@mozdevchallenge.org", :password => 'user')
  user.save!
  Profile.create!(:user => user, :username => "user#{i}", :name => "User #{i}")
end

# Challenges

challenges = [
  {:title =>'RSpec formatters', :abstract => 'RSpec has a bunch of formatters you can use when running your tests. The default is the "progress" formatter, which prints out a green dot for every spec tat passes and a red "F" for every spec that fails. There are more, like the "documentation" and "html" formatters.

  This week, the challenge is to create your own formatter for RSpec 2. Your solution should solve a problem you\'re facing with the existing formatters (like, I don\'t know how long my specs are going to take or I don\'t notice when my suite is done running) or you can do something completely crazy and funny. With rainbows, or something like that. Oh, and remember: You\'re not limited to terminal output, do whatever you can think of.

  Creating an RSpec formatter is quite straightforward. Be sure to check out the existing formatters, since you\'re probably going to extend one of those. For more information, you can check out the Fuubar source.

  When you\'re done, put your solution in a Gist, including a README.(markdown|textile) file to explain what it does, how it works and why it should win. Of course, you\'re encouraged to put a link to a demo video of your formatter in action in your Gist too.

  You have a week to enter, so that should be enough to think of something great. Good luck!'},
  {:title =>'Pixelizing images with ChunkyPNG', :abstract => 'Ever heard of ChunkyPNG? It\'s an amazing PNG manipulation library that is easy and fun to use. This week\'s challenge is to pixelize the image below, so your resulting image is built up from blocks of 10 by 10 pixels. Remember: you can\'t change the size of the image.

  If you\'ve never used ChunkyPNG before, check out the wiki, you can find some great examples in there.

  Again, put your solution in a Gist, together with your resulting image, like this example (please don\'t include the input image and don\'t fork the example gist). You can\'t add images using Gist\'s web interface, so you\'ll have to clone your Gist and add it using git.

  Like last week, you have a week to get your entry in, so I\'m sure you have enough time to write a great implementation. Good luck!'},
  {:title =>'Terminal admin', :abstract => "Codebrawl doesn't have a proper admin panel, so I tend to do content changes in the database directly using script/rails console. This gives me a lot of freedom, since I can do anything without having to build features for it in my admin panel first. Also, if Codebrawl had an admin panel, I'm absolutely sure I would have to dive into the console to do stuff every once in a while.

  Of course, there are some problems with the console when trying to quickly edit a record. Finding the right one requires you to type a query:

  c = Contest.first(:conditions => {:name => 'Terminal Admin'})
  Also, editing a field requires you to fill in the whole value every time:

  c.update_attribute(:description => 'Codebrawl doesn't have a proper...')
  The challenge for this week is to think of something that makes this easier and faster. Tackle one problem (like finding records, for example) the best you can, but don't try to build a complete terminal admin. The idea is to combine good ideas into one project we can keep working on.

  Create a solution you can require into the console. It needs to hook into your ORM of choice (Codebrawl uses Mongoid, but you can build something for another ORM if you want), like in this example Gist. Also, don't forget to add a REAME file explaining how it works.

  No shirt, no shoes, no weapons. You have one week to get your entry in. Good luck!"}
]

challenges.each do |challenge|
  Challenge.create!(
    :user => User.admins.all.sample,
    :level => Level.all.sample,
    :category => Category.all.sample,
    :platform => Platform.all.sample,
    :duration => Duration.all.sample,
    :source => 'admin',
    :title => challenge[:title],
    :abstract => challenge[:abstract]
  )
end

attempts = ['Attempt1', 'Attempt2', 'Attempt3']

# set one challenge as active
challenge = Challenge.pending.sample
challenge.activate!
attempts.each do |attempt|
  challenge.attempts.create!(
    :user => (User.ordinary - challenge.attempts.collect{|x| x.user}).sample,
    :language => Language.all.sample,
    :repository_url => 'http://github.com/',
    :description => attempt
  )
end

# set one challenge as active and open for comments
challenge = Challenge.pending.sample
challenge.activate!

attempts.each do |attempt|
  challenge.attempts.create!(
    :user => (User.ordinary - challenge.attempts.collect{|x| x.user}).sample,
    :language => Language.all.sample,
    :repository_url => 'http://github.com/',
    :description => attempt
  )
end

challenge.update_attributes(:activated_at => Time.now.utc - challenge.duration.duration)


