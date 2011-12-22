require 'spec_helper'

describe Company do
  #include NullDB::RSpec::NullifiedDatabase
  
  it "should have a name" do
    should have_db_column(:name).of_type(:string)
  end
  
  it "should validate the uniqueness of name" do
    subject.class.validators_on(:name).select{|v|v.is_a? (ActiveRecord::Validations::UniquenessValidator)}.should_not be_empty
    subject.should have_db_index(:name).unique(true)
  end
  
  it { should have_many(:projects) }
  
  it "has a mood" do
    subject.mood.should == 'unknown'
  end
  
end
