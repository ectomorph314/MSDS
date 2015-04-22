require 'rails_helper'
require 'support/authentication_helper'

include AuthenticationHelper

feature 'admin deletes user', %{
  As an authenticated admin
  I want to delete a user
  So that they no longer have access to the database
} do
  # Acceptance Criteria:
  #   Admin clicks to create a new company
  # 	Admin fills in a name (required, unique)
  # 	Admin submits form
  # 	Admin is redirected to company show page, if successful
  # 	Admin should be presented with form and errors, if unsuccessful

  scenario 'admin deletes a user' do
    admin = FactoryGirl.create(:user, role: 'admin')
    company = FactoryGirl.create(:company, user_id: admin.id)
    CompanyUser.create(company_id: company.id, user_id: admin.id)
    sign_in_as(admin)
    user = FactoryGirl.create(:user)

    visit users_path

    within("##{user.id}") do
      click_on 'Delete User'
    end

    expect(page).to have_content('User deleted.')
    expect(page).to_not have_content(user.email)
  end
end
