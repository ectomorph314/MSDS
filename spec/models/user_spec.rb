require 'rails_helper'

RSpec.describe User, type: :model do
  it { should have_one(:company) }
  it { should have_one(:company_user) }

  it { should validate_presence_of(:role) }
  it { should have_valid(:role).when('admin') }
  it { should_not have_valid(:role).when('guest') }

  it 'should validate uniqueness of user' do
    user = FactoryGirl.create(:user)
    user2 = FactoryGirl.build(:user, email: user.email)

    expect { user2.save! }.to raise_error(ActiveRecord::RecordInvalid)
  end

  describe 'admin_access?' do
    context 'user is an admin' do
      it 'returns true' do
        admin = FactoryGirl.create(:user, role: 'admin')
        company = FactoryGirl.create(:company, user_id: admin.id)
        CompanyUser.create(company_id: company.id, user_id: admin.id)
        expect(admin.admin_access?(company)).to eq true
      end

      it 'returns false' do
        admin = FactoryGirl.create(:user, role: 'admin')
        company = FactoryGirl.create(:company, user_id: admin.id)
        expect(admin.admin_access?(company)).to eq false
      end
    end

    context 'user has company' do
      it 'returns true' do
        admin = FactoryGirl.create(:user, role: 'admin')
        company = FactoryGirl.create(:company, user_id: admin.id)
        CompanyUser.create(company_id: company.id, user_id: admin.id)
        expect(admin.admin_access?(company)).to eq true
      end

      it 'returns false' do
        user = FactoryGirl.create(:user)
        company = FactoryGirl.create(:company, user_id: user.id)
        CompanyUser.create(company_id: company.id, user_id: user.id)
        expect(user.admin_access?(company)).to eq false
      end
    end
  end
end
