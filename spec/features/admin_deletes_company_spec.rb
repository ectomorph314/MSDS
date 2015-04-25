require 'rails_helper'
require 'support/authentication_helper'

include AuthenticationHelper

feature 'admin deletes company', %{
  As an authenticated admin
  I want to delete my company
  So that my company doesn't use the app
} do
  # Acceptance Criteria:
  #   Admin visits company show page
  #   Admin clicks to delete a company
  # 	Admin confirms that they want to delete
  # 	Admin is redirected to the home page

  scenario 'admin deletes a company' do
    admin = FactoryGirl.create(:user, role: 'admin')
    company = FactoryGirl.create(:company, user_id: admin.id)
    CompanyUser.create(company_id: company.id, user_id: admin.id)
    sign_in_as(admin)

    visit company_path(company)
    click_on 'Delete Company'

    expect(page).to have_content('Company deleted.')
  end

  scenario 'owner deletes a company' do
    owner = FactoryGirl.create(:user, role: 'owner')
    company = FactoryGirl.create(:company, user_id: owner.id)
    sign_in_as(owner)

    visit companies_path
    click_on 'Delete Company'

    expect(page).to have_content('Company deleted.')
    expect(page).to_not have_content(company.name)
  end

  scenario 'user tries to deletes a company' do
    user = FactoryGirl.create(:user)
    company = FactoryGirl.create(:company, user_id: user.id)
    CompanyUser.create(company_id: company.id, user_id: user.id)
    sign_in_as(user)

    visit company_path(company)
    expect(page).to_not have_content('Delete Company')
  end
end
