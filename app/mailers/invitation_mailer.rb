class InvitationMailer < ActionMailer::Base

  def invitation(model)
    @project_name = model.project_name
    mail(:to => model.recipient_email,
         :subject => "Invitation",
         :from => model.sender_email)
  end
  
end
