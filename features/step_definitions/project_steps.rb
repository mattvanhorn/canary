When /^I create a project named "([^"]+)"$/ do |name|
  fill_in I18n.t('formtastic.labels.project.name'), :with => name
  click_on I18n.t('formtastic.actions.create', :model => 'Project')
end

When /^I create a project without a name$/ do 
  click_on I18n.t('formtastic.actions.create', :model => 'Project')
end
