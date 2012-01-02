Transform /^(should|should not)$/ do |should_or_not|
  should_or_not.gsub(' ', '_').to_sym
end
