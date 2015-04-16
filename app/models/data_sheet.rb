class DataSheet < ActiveRecord::Base
  belongs_to :company

  validates :name,
    presence: true,
    uniqueness: true

  validates :sds,
    presence: true

  validates :company, presence: true
end
