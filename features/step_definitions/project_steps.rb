When /^I create a project named "([^"]+)"$/ do |name|
  fill_in I18n.t('simple_form.labels.project.name'), :with => name
  click_on I18n.t('helpers.submit.project.create', :model => 'Project')
end

When /^I create a project without a name$/ do 
  click_on I18n.t('helpers.submit.project.create', :model => 'Project')
end

When /^I am a member of "([^"]*)"$/ do |name|
  p = Project.find_by_name(name)
  p.users << @me
  p.save!
end

When /^I should see (\d+) members?$/ do |num|
  page.should have_selector('ul.project li.user', :count => num)
end