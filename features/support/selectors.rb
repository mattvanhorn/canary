# I'm in features/support/selectors.rb

module HtmlSelectorsHelper
  def selector_for(scope)
    case scope
    when /the body/
      "html > body"
    when /the page header/
      "#page-header"
    when /the project (.*) input area/
      "#project_#{$1}_input"
    else
      raise "Can't find mapping from \"#{scope}\" to a selector.\n" +
        "Now, go and add a mapping in #{__FILE__}"
    end
  end
end

World(HtmlSelectorsHelper)