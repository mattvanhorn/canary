class InvitationMailer < ActionMailer::Base

  def invitation(model)
    @invitation = model

    mail(:to => model.recipient_email,
         :subject => "Invitation",
         :from => model.sender_email)
  end

end
