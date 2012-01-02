# Handles invitations that get emailed to teammates
class InvitationMailer < ActionMailer::Base

  def invitation(model)
    @invitation = model

    mail(:to => model.recipient_email,
         :subject => "MoodMetrics Invitation",
         :from => "info@moodmetricsapp.com",
         :reply_to => model.sender_email)
  end

  def project_link(recipient, project)
    @project = project
    mail(:to => recipient,
         :subject => "MoodMetrics Project",
         :from => "info@moodmetricsapp.com")
  end
end
