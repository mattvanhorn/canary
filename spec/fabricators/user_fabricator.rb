Fabricator(:user) do
  email "alice@example.com"
  password "password"
  password_confirmation "password"
end

Fabricator(:happy_user, :from => :user) do
  email                     { sequence(:email) { |i| "happy_user#{i}@example.com" }}
  mood_updates!(:count => 1) { |user, idx| Fabricate(:mood_update, :user => user, :project => user.projects.last, :mood_score => 3 )}
end
