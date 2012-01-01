# Handles invitations that get emailed to teammates
class InvitationMailer < ActionMailer::Base

  def invitation(model)
    @invitation = model

    mail(:to => model.recipient_email,
         :subject => "MoodMetrics Invitation",
         :from => "info@moodmetricsapp.com",
         :reply_to => model.sender_email)
  end

end
