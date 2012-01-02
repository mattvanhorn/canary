Then /^(?:they|I) should be on (.+)$/ do |page_name|
  location = URI.parse(current_url).path
  expected = path_to(page_name)
  if path_to(page_name).respond_to?(:match)
    expected.should match(location)
  else
    location.should == expected
  end
end

When /^(?:they|I) (?:visit|am on|are on) (.+)$/ do |page_name|
  visit path_to(page_name)
end

Then /^(?:they|I) (should|should not) see "([^"]*)"$/ do |should_or_not, content|
  page.send should_or_not, have_content(content)
end

Then /^(?:they|I) should see a link to (.+)$/ do |page_name|
  page.should have_selector("a[href='#{path_to(page_name)}']")
end

Then /^(?:they|I) should not see a link to (.+)$/ do |page_name|
  page.should_not have_selector("a[href='#{path_to(page_name)}']")
end

Then /^show me the page$/ do
  save_and_open_page
end

Then /^show me the response$/ do
  puts headers
end

When /^(?:they|I) follow "([^"]*)"$/ do |link|
  click_link(link)
end

When /^(?:they|I) click on "([^"]*)"$/ do |link_or_button|
  click_on(link_or_button)
end

When /^(?:they|I) (?:select|choose) "([^"]*)" from "([^"]*)"$/ do |value, field|
  select(value, :from => field)
end

When /^(?:they|I) fill in "([^"]*)" with "([^"]*)"$/ do |field, value|
  fill_in(field, :with => value)
end

When /^(?:they|I) fill in "([^"]*)" for "([^"]*)"$/ do |value, field|
  fill_in(field, :with => value)
end

When /^(.*) within ([^:"]+)$/ do |scoped_step, scope|
  within(selector_for(scope)) do
    step(scoped_step)
  end
end

When /^(.*) within ([^:"]+):$/ do |scoped_step, scope, table_or_string|
  within(selector_for(scope)) do
    step("#{scoped_step}:", table_or_string)
  end
end