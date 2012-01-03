When /^I should see (\d+) (\w+) team member$/ do |num, mood|
  within('ul.column:last-child') do
    page.should have_selector('li.happy', :count => num.to_i)
  end
end

When /^I submit the update$/ do
  click_on I18n.t('helpers.submit.mood_update.create')
end
