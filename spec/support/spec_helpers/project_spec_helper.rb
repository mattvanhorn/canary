module ProjectSpecHelper
  def valid_project_attributes
    @valid_project_attributes ||= {
      'name' => "#{Faker::Company.name} Website"
    }
  end
end