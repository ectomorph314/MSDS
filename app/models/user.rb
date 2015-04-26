class User < ActiveRecord::Base
  has_one :company
  has_one :company_user, dependent: :destroy

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  validates :role,
    presence: true,
    inclusion: { in: %w(member admin owner) }

  def admin_access?(company_id)
    CompanyUser.exists?(company_id: company_id, user_id: self) && role == 'admin'
  end
end
