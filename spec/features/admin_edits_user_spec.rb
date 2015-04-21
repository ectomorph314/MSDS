require 'rails_helper'
require 'support/authentication_helper'

include AuthenticationHelper

feature 'admin edits user', %{
  As an authenticated admin
  I want to edit user profiles from my company
  So that I can add them to my company profile
} do
  # Acceptance Criteria:
  #   Admin clicks to edit user
  # 	Admin can promote user to admin
  #   Admin can add user to a company
  # 	Admin submits form
  # 	Admin is redirected to company show page, if successful
  # 	Admin should be presented with form and errors, if unsuccessful

  scenario 'admin edits a company successfully' do
    admin = FactoryGirl.create(:user, role: 'admin')
    company = FactoryGirl.create(:company, user_id: admin.id)
    CompanyUser.create(company_id: company.id, user_id: admin.id)
    sign_in_as(admin)
    user = FactoryGirl.create(:user)

    visit edit_user_path(user)
    expect(page).to_not have_content('Owner')

    choose 'Admin'
    select company.name
    click_on 'Update'

    expect(page).to have_content('Admin')
    expect(page).to_not have_content('Member')
  end

  scenario 'user tries to edit a user' do
    user1 = FactoryGirl.create(:user)
    sign_in_as(user1)
    user2 = FactoryGirl.create(:user)

    visit edit_user_path(user2)
    expect(page).to have_content("You don't have access to this page!")
  end

  scenario 'visitor tries to edit a user' do
    user = FactoryGirl.create(:user)

    visit edit_user_path(user)
    expect(page).to have_content('You need to sign in or sign up before continuing.')
  end
end
