Fabricator(:mood_update) do
  membership
  mood_score [0,1,2,3].sample
end
