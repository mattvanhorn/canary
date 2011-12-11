When /^I should see (\d+) (\w+) team member$/ do |num, mood|
  page.should have_selector('li.member.happy', :count => num.to_i)
end
