class Contribution < ActiveRecord::Base
  belongs_to :person
  belongs_to :industry
  belongs_to :state, :foreign_key => 'contributor_state_id'
  scope :grouped_by_name, select("contributions.contributor_name, sum(contributions.amount) as amount").group("contributions.contributor_name").order("amount desc")
  scope :grouped_by_recipient, select("contributions.person_id, sum(contributions.amount) as amount").group("contributions.person_id").order("amount desc").includes(:person)
  scope :grouped_by_sector, lambda { |letter| select("sum(contributions.amount) as amount").where(["contributions.industry_id like '?%'", letter]).order("amount desc") }

  validates :industry, :presence => true

end
