class DataSheet < ActiveRecord::Base
  belongs_to :company
  mount_uploader :sds, DataSheetUploader

  validates :name,
    presence: true,
    uniqueness: true

  validates :sds,
    presence: true

  validates :company, presence: true
end
