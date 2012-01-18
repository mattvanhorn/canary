# I'm in features/support/selectors.rb

module HtmlSelectorsHelper
  def selector_for(scope)
    case scope
    when /the body/
      "html > body"
    when /the page header/
      "#page-header"
    when /the project (.*) input area/
      "form.project .project-#{$1} .input"
    when /the mood indicator/
      "#mood_update_mood_score_input"
    when /the sign up form/
      "#sign-up-form"
    when /the sign in form/
      "#sign-in-form"
    when /project member/
      'ul.project li.user'
    when /recent comments/
      'ul.recent-comments'
    else
      raise "Can't find mapping from \"#{scope}\" to a selector.\n" +
        "Now, go and add a mapping in #{__FILE__}"
    end
  end
end

World(HtmlSelectorsHelper)