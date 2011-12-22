25.times do 
  c = Company.create(:name => Faker::Company.name)
  rand(5).times do
    u = User.create(:email => Faker::Internet.email, :password => 'password', :password_confirmation => 'password')
    p = c.projects.create(:name => Faker::Company.bs)
    u.join(p)
    u.update_mood(MoodUpdate.new(:mood_score => rand(4), :project_id => p.id))
    (rand(4)+4).times do
      m = User.create(:email => Faker::Internet.email, :password => 'password', :password_confirmation => 'password')
      m.join(p)
      m.update_mood(MoodUpdate.new(:mood_score => rand(4), :project_id => p.id))
    end
  end
end