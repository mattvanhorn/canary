require 'spec_helper'

describe Project do
  include NullDB::RSpec::NullifiedDatabase
  
  it "should have a name" do
    should have_db_column(:name).of_type(:string)
  end
  
  it { should have_many(:memberships) }
  it { should have_many(:users).through(:memberships) }
  it { should have_many(:invitations) }
  it { should have_many(:mood_updates) }
  
  it { should validate_presence_of(:name) }
  it "should validate the uniqueness of name" do
    subject.class.validators_on(:name).select{|v|v.is_a? (ActiveRecord::Validations::UniquenessValidator)}.should_not be_empty
    subject.should have_db_index(:name).unique(true)
  end
  
end
