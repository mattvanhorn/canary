When /^I have an account$/ do
  Fabricate(:identity, :email => 'alice@example.com')
end

When /^I submit my valid registration information$/ do
  fill_in I18n.t('sign_up.auth_key'), :with => 'user@example.com'
  fill_in I18n.t('sign_up.password'), :with => 'foobar'
  fill_in I18n.t('sign_up.password_confirmation'), :with => 'foobar'
  click_on I18n.t('sign_up.submit')
end

When /^I submit my registration information without an email$/ do
  fill_in I18n.t('sign_up.password'), :with => 'foobar'
  fill_in I18n.t('sign_up.password_confirmation'), :with => 'foobar'
  click_on I18n.t('sign_up.submit')
end

When /^I submit my registration information without a password$/ do
  fill_in I18n.t('sign_up.auth_key'), :with => 'user@example.com'
  fill_in I18n.t('sign_up.password_confirmation'), :with => 'foobar'
  click_on I18n.t('sign_up.submit')
end

When /^I submit my registration information without a password confirmation$/ do
  fill_in I18n.t('sign_up.auth_key'), :with => 'user@example.com'
  fill_in I18n.t('sign_up.password'), :with => 'foobar'
  click_on I18n.t('sign_up.submit')
end

When /^I submit my registration information without password matching confirmation$/ do
  fill_in I18n.t('sign_up.auth_key'), :with => 'user@example.com'
  fill_in I18n.t('sign_up.password'), :with => 'foobar'
  fill_in I18n.t('sign_up.password_confirmation'), :with => 'barbaz'
  click_on I18n.t('sign_up.submit')
end
