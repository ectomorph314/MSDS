class Department < ActiveRecord::Base
  belongs_to :company
  has_many :data_sheets

  validates :name,
    presence: true

  validates :company, presence: true
end
