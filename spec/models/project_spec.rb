require 'spec_helper'

describe Project do
  include NullDB::RSpec::NullifiedDatabase
  
  it "should have a name" do
    should have_db_column(:name).of_type(:string)
  end
  
  it { should belong_to(:company) }
  
  it { should have_many(:memberships) }
  
  it { should have_many(:users).through(:memberships) }
  
  it { should have_many(:invitations) }
  
  it { should have_many(:mood_updates).through(:memberships) }
  
  it { should validate_presence_of(:name) }
  
  it "should validate the uniqueness of name, within a company" do
    subject.class.validators_on(:name).select{|v| (v.is_a? ActiveRecord::Validations::UniquenessValidator) && (v.options[:scope] == :company_id)}.should_not be_empty
    subject.should have_db_index([:company_id, :name]).unique(true)
  end
  
  it "should accept nested attributes for company" do
    subject.should respond_to(:company_attributes=)
  end
  
  it "should only process nested attributes for new records" do
    subject.should_receive(:new_record?).and_return(false)
    subject.should_not_receive(:company=)
    subject.company_attributes = {:name => 'Initech', :id => '42'}
  end
  
  it "has a company name" do
    subject.company = mock_model(Company, :name => 'foobar')
    subject.company_name.should == 'foobar'
  end
  
  it "has no company name without a company" do
    subject.company = nil
    subject.company_name.should be_nil
  end
  
  describe "being created with nested attributes for company" do
    let(:existing_company){ stub_model(Company) }
    let(:new_company){ stub_model(Company) }
    
    before(:each) do
      Company.stub(:find_by_id).and_return(existing_company)
      Company.stub(:find_or_create_by_name).and_return(new_company)
    end
    
    describe "including a valid company id and a name" do
      
      it "finds the company" do
        project = Project.new(:company_attributes => {:name => 'Initech', :id => '42'})
        project.company.should == existing_company
      end
    end
    
    describe "including a blank company id and a name" do

      it "finds or creates the company by name" do
        project = Project.new(:company_attributes => {:name => 'Initech', :id => ''})
        project.company.should == new_company
      end
    end
    
    describe "including a blank company id and a blank name" do

      it "does nothing" do
        project = Project.new(:company_attributes => {:name => '', :id => ''})
        project.company.should be_nil
      end
    end
  end
  
  describe "calculating moods" do
    
    let(:project){ Project.new }
    context "with some updates" do
      before(:each) do
        Rails.stub_chain(:cache, :fetch).and_yield
        m1 = mock_model(MoodUpdate, :mood_score => 3 )
        m2 = mock_model(MoodUpdate, :mood_score => 1 )
        m3 = mock_model(MoodUpdate, :mood_score => 2 )
        project.should_receive(:most_recent_mood_updates).and_return([m1,m2,m3])
      end
    
      it "can calculate an average mood score" do
        project.average_mood_score.should == 2
      end

      it "has a mood" do
        project.mood.should == 'satisfied'
      end
    end
    
    context "with no updates" do
      before(:each) do
        project.should_receive(:most_recent_mood_updates).and_return([])
      end
      
      it "has an unknown mood" do
        project.mood.should == 'unknown'
      end
    end
  end

end
