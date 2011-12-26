When /^I invite "([^"]*)" to the project "([^"]*)"$/ do |email, project_name|
  visit new_project_invitation_path(Project.find_by_name(project_name))
  fill_in I18n.t('simple_form.labels.invitation.recipient_email'), :with => email
  click_on I18n.t('helpers.submit.invitation.create', :model => 'Invitation')
end

When /^(?:I|they) submit "([^"]*)" as (?:my|their) new password$/ do |password|
  fill_in I18n.t('sign_up.password'), :with => password
  fill_in I18n.t('sign_up.password_confirmation'), :with => password
  click_on I18n.t('sign_up.submit')
end