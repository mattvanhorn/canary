module NavigationHelpers
  # Maps a name to a path. Used by the
  #
  #   When /^I go to (.+)$/ do |page_name|
  #
  # step definition in web_steps.rb
  #
  def path_to(page_name)
    case page_name

    when /the home\s?page/
      '/'

    when /the sign-up page/
      sign_up_path

    when /the failed sign-up page/
      '/auth/identity/register'

    when /the sign-out page/
      sign_out_path

    when /the sign-in page/
      sign_in_path

    when /the invite members page for "([^"]+)"/
      new_project_invitation_path(Project.find_by_name($1))

    when /the accept invitation page/
      /\/invitations\/accept\/[^\/]+/

    when /my projects page/
      my_projects_path

    when /the project page for "([^"]+)"/
      project_path(Project.find_by_name($1))

    when /the project mood updates page for "([^"]+)"/
      project_mood_updates_path(Project.find_by_name($1))

    when /the about page/
      "/about"

    else
      begin
        page_name =~ /the (.*) page/
        path_components = $1.split(/\s+/)
        self.send(path_components.push('path').join('_').to_sym)
      rescue Object => e
        raise "Can't find mapping from \"#{page_name}\" to a path.\n" +
          "Now, go and add a mapping in #{__FILE__}"
      end
    end
  end
end

World(NavigationHelpers)