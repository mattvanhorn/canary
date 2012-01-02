require "spec_helper"

describe InvitationMailer do
  include EmailSpec::Helpers
  include EmailSpec::Matchers
  #
  # include Rails.application.routes.url_helpers

  describe "invitation" do
    let(:invitation) { mock_model( Invitation,
        :sender_email => 'alice@example.com',
        :recipient_email => 'bob@example.com',
        :project_name => 'Yoyodyne Website',
        :token => 'abc123') }

    let(:mail) { InvitationMailer.invitation(invitation) }

    it "renders the subject" do
      mail.should have_subject(I18n.t('invitations.email.subject'))
    end

    it "renders the body" do
      mail.should have_body_text(/Yoyodyne Website/)
    end

    it "is sent from the application's Postmark authorized address" do
      mail.should be_delivered_from(I18n.t('invitations.email.signature'))
    end

    it "has reply_to the invitation's user" do
      mail.should have_reply_to("alice@example.com")
    end

    it "is sent to the invitation's email recipient" do
      mail.should deliver_to("bob@example.com")
    end

  end

end




