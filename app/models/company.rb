class Company < ActiveRecord::Base
  belongs_to :user

  validates :name,
    presence: true,
    uniqueness: true

  validates :user, presence: true
end
