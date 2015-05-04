require 'rails_helper'

describe Company do
  it { should belong_to(:user) }
  it { should have_many(:data_sheets) }
  it { should have_many(:company_users) }
  it { should have_many(:departments) }

  it { should validate_presence_of(:name) }

  it 'should validate uniqueness of company' do
    user = FactoryGirl.create(:user)
    company = FactoryGirl.create(:company, user_id: user.id)
    company2 = FactoryGirl.build(:company, name: company.name, user_id: user.id)

    expect { company2.save! }.to raise_error(ActiveRecord::RecordInvalid)
  end
end
