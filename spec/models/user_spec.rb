require 'spec_helper'

describe User do  
  it { should have_many(:identities) }
  it { should have_many(:memberships) }
  it { should have_many(:projects).through(:memberships) }
  
  it "can be a member of a project" do
    project = mock_model(Project)
    membership = mock_model(Membership, :project => project)
    user = User.new
    user.memberships << membership
    user.should be_member_of(project)
  end
end
