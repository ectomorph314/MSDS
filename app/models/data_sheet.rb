class DataSheet < ActiveRecord::Base
  belongs_to :company
  mount_uploader :sds, DataSheetUploader

  validates :number,
    presence: true

  validates :name,
    presence: true

  validates :sds,
    presence: true

  validates :company, presence: true

  def self.search(query)
    # where(:title, query) -> This would return an exact match of the query
    where('number ILIKE ? OR name ILIKE ? OR sds ILIKE ?', "%#{query}%", "%#{query}%", "%#{query}%")
  end
end
