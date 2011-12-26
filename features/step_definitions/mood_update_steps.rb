When /^I should see (\d+) (\w+) team member$/ do |num, mood|
  page.should have_selector('li.member.happy', :count => num.to_i)
end

When /^I submit the update$/ do
  click_on I18n.t('helpers.submit.mood_update.create')  
end
