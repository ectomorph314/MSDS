class Company < ActiveRecord::Base
  belongs_to :user
  has_many :data_sheets

  validates :name,
    presence: true,
    uniqueness: true

  validates :user, presence: true
end
