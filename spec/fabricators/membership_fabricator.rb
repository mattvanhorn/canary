Fabricator(:member, :from => :membership) do
  project
  user
end

Fabricator(:happy_member, :from => :member) do
  project!
  user! { Fabricate(:user, :email => sequence(:email) { |i| "happy_user_#{i}@example.com" }) }
  mood_updates!(:count => 1) { |membership, i| Fabricate(:mood_update, :mood_score => 3, :membership => membership) }
end

Fabricator(:frustrated_member, :from => :member) do
  project!
  user! { Fabricate(:user, :email => sequence(:email) { |i| "frustrated_user_#{i}@example.com" }) }
  mood_updates!(:count => 1) { |membership, i| Fabricate(:mood_update, :mood_score => 0, :membership => membership) }
end
