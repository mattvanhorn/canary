Fabricator(:identity) do
  user!
  email "test@example.com"
  password "password"
  password_confirmation "password"
end