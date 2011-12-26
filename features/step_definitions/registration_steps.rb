When /^I have an account$/ do
  @me = Fabricate(:user, :email => 'alice@example.com')
  raise 'hell' unless User.find_by_email('alice@example.com')
end

When /^I submit my valid registration information$/ do
  within(selector_for("the sign up form")) do
    fill_in I18n.t('sign_up.auth_key'), :with => 'user@example.com'
    fill_in I18n.t('sign_up.password'), :with => 'foobar'
    fill_in I18n.t('sign_up.password_confirmation'), :with => 'foobar'
    click_on I18n.t('sign_up.submit')
  end
end

When /^I submit my registration information without an email$/ do
  within(selector_for("the sign up form")) do
    fill_in I18n.t('sign_up.password'), :with => 'foobar'
    fill_in I18n.t('sign_up.password_confirmation'), :with => 'foobar'
    click_on I18n.t('sign_up.submit')
  end
end

When /^I submit my registration information without a password$/ do
  within(selector_for("the sign up form")) do
    fill_in I18n.t('sign_up.auth_key'), :with => 'user@example.com'
    fill_in I18n.t('sign_up.password_confirmation'), :with => 'foobar'
    click_on I18n.t('sign_up.submit')
  end
end

When /^I submit my registration information without a password confirmation$/ do
  within(selector_for("the sign up form")) do
    fill_in I18n.t('sign_up.auth_key'), :with => 'user@example.com'
    fill_in I18n.t('sign_up.password'), :with => 'foobar'
    click_on I18n.t('sign_up.submit')
  end
end

When /^I submit my registration information without password matching confirmation$/ do
  within(selector_for("the sign up form")) do
    fill_in I18n.t('sign_up.auth_key'), :with => 'user@example.com'
    fill_in I18n.t('sign_up.password'), :with => 'foobar'
    fill_in I18n.t('sign_up.password_confirmation'), :with => 'barbaz'
    click_on I18n.t('sign_up.submit')
  end
end
