class CompanyUser < ActiveRecord::Base
  belongs_to :company
  belongs_to :user

  validates :company, presence: true
  validates :user, presence: true
end
