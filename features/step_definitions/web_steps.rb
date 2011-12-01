Then /^(?:|I )should be on (.+)$/ do |page_name|
  URI.parse(current_url).path.should == path_to(page_name)
end

When /^I (?:visit|am on) (.+)$/ do |page_name|
  visit path_to(page_name)
end

Then /^I should see "([^"]*)"$/ do |content|
  page.should have_content(content)
end

Then /^I should see a link to (.+)$/ do |page_name|
  page.should have_selector("a[href='#{path_to(page_name)}']")
end

Then /^I should not see a link to (.+)$/ do |page_name|
  page.should_not have_selector("a[href='#{path_to(page_name)}']")
end

Then /^show me the page$/ do
  save_and_open_page
end

When /^(?:|I )follow "([^"]*)"$/ do |link|
  click_link(link)
end