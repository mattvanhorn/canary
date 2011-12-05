When /^I create a project named "([^"]+)"$/ do |name|
  fill_in I18n.t('formtastic.labels.project.name'), :with => name
  click_on I18n.t('formtastic.actions.create', :model => 'Project')
end

When /^I create a project without a name$/ do 
  click_on I18n.t('formtastic.actions.create', :model => 'Project')
end

Given /^I am a member of "([^"]*)"$/ do |name|
  p = Project.find_by_name(name)
  p.users << @me
  p.save!
end
