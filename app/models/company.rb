# == Schema Information
# Schema version: 20111230200612
#
# Table name: companies
#
#  id         :integer         not null, primary key
#  name       :string(255)
#  created_at :datetime
#  updated_at :datetime
#
# Indexes
#
#  index_companies_on_name  (name) UNIQUE
#

class Company < ActiveRecord::Base
  has_many :projects

  validates :name, :presence =>true, :uniqueness => true

  def self.for_new_project(company_id, company_name)
    return find_by_id(company_id) unless company_id.blank?
    return find_or_create_by_name(company_name) unless company_name.blank?
  end

  def mood
    'unknown'
  end

end
