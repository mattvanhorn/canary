require 'spec_helper'

describe SimpleForm::Components::ContainedInput do
  let(:object){mock_model(Project, :name => 'Frobnitz')}
  let(:builder){SimpleForm::FormBuilder.new(:project, object, self, {}, nil)}
  
  it "wraps the input" do
    builder.input(:name).to_s.should have_selector('div.input')
  end
  
  it "shows hints" do
    builder.input(:name).to_s.should have_selector('div.input')
  end
  
  it "shows hints" do
    builder.input(:name, :hint => 'foobar').to_s.should have_selector('span.help-inline', :content => 'foobar')
  end
  
  it "shows errors instead of hints" do
    object.stub(:errors).and_return({:name => ['must be real']})
    builder = SimpleForm::FormBuilder.new(:project, object, self, {}, nil)
    builder.input(:name, :hint => 'foobar').to_s.should have_selector('div.error span.help-inline', :content => 'name must be real')
  end
end
