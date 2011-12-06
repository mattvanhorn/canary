When /^I invite "([^"]*)" to the project "([^"]*)"$/ do |email, project_name|
  visit new_project_invitation_path(Project.find_by_name(project_name))
  fill_in I18n.t('formtastic.labels.invitation.recipient_email'), :with => email
  click_on I18n.t('formtastic.actions.create', :model => 'Invitation')
end
