require 'spec_helper'

describe MoodHistory do
  let(:first_updated){ 3.days.ago.in_time_zone }
  let(:today){ Time.zone.now }
  let(:user){ mock_model(User) }
  let(:project){ mock_model(Project, :users => [user]) }
  let(:mood_update){ mock_model(MoodUpdate, :updated_at => first_updated, :project => project, :user => user, :date => first_updated.beginning_of_day) }

  describe "with no updates" do
    it "still includes today" do
      history = MoodHistory.new(project, [user])
      history.number_of_days.should == 1
      history.on(today).should == [nil]
    end
  end

  describe "with an update" do
    before(:each) do
      MoodUpdate.stub_chain(:for_project, :chronological).and_return([mood_update])
      @history = MoodHistory.new(project, [user])
    end

    it "has a column for every day in the mood history" do
     @history.number_of_days.should == 4
    end

    it "has the day's updates for each member in each column" do
      first_day = @history.days.first
      @history.on(first_day).should == [mood_update]
    end

    it "has nils where a user has not made an update" do
      last_day = @history.days.last
      @history.on(last_day).should == [nil]
    end
  end

  describe "initialization" do
    before(:each) do
      @orig_stderr = $stderr
      $stderr = StringIO.new
    end

    after do
      $stderr = @orig_stderr
    end

    it "warns when there is a project/user mismatch" do
      project.stub_chain(:mood_updates, :includes, :order).and_return([mood_update])
      other_user = mock_model(User)
      MoodHistory.new(project, [other_user])
      $stderr.rewind
      $stderr.string.chomp.should match(/user ids: \[\d+\] were not associated with project and were ignored!/)
    end
  end

  describe "calculations" do
    let(:user1){ mock_model(User) }
    let(:user2){ mock_model(User) }
    let(:mood_update1){ mock_model(MoodUpdate, :mood_score => 3, :updated_at => first_updated, :project => project, :user => user1, :date => first_updated.beginning_of_day) }
    let(:mood_update2){ mock_model(MoodUpdate, :mood_score => 1, :updated_at => first_updated, :project => project, :user => user2, :date => first_updated.beginning_of_day) }
    let(:mood_update3){ mock_model(MoodUpdate, :mood_score => 3, :updated_at => first_updated - 1.day, :project => project, :user => user2, :date => (first_updated - 1.day).beginning_of_day) }

    before(:each) do
      project.stub(:users).and_return( [user1, user2])
      MoodUpdate.stub_chain(:for_project, :chronological).and_return([mood_update1, mood_update2])
      @history = MoodHistory.new(project, project.users)
    end
    it "gets an avg mood score for a day" do
      @history.avg_mood_score_on(first_updated).should == 2
    end
  end
end
