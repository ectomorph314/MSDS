require 'rails_helper'
require 'support/authentication_helper'

include AuthenticationHelper

feature 'user views data sheets', %{
  As an authenticated user
  I want to view my company
  So that I see a list of relevant data sheets
} do
  # Acceptance Criteria:
  #   User signs in

  scenario "user views their company's data sheets" do
    user = FactoryGirl.create(:user)
    company = FactoryGirl.create(:company, user_id: user.id)
    data_sheet = FactoryGirl.create(:data_sheet, company_id: company.id)
    CompanyUser.create(company_id: company.id, user_id: user.id)
    sign_in_as(user)

    visit company_path(company)
    expect(page).to have_content(data_sheet.number)
    expect(page).to have_content(data_sheet.name)
  end

  scenario "user tries to view other company's data sheets" do
    admin = FactoryGirl.create(:user, role: 'admin')
    user = FactoryGirl.create(:user)
    company = FactoryGirl.create(:company, user_id: admin.id)
    sign_in_as(user)

    visit company_path(company)
    expect(page).to have_content("You don't have access to this page!")
  end
end
