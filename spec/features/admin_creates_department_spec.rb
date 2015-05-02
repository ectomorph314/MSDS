require 'rails_helper'
require 'support/authentication_helper'

include AuthenticationHelper

feature 'admin creates new department', %{
  As an authenticated admin
  I want to add a department
  So that others can find their data easily.
} do
  # Acceptance Criteria:
  #   Admin signs in and goes to department index page
  # 	Admin clicks to create new department
  # 	Admin fills in a name (required)
  # 	Admin submits form
  # 	Admin is redirected to department index page, if successful
  # 	Admin should be presented with form and errors, if unsuccessful

  scenario 'admin adds valid department' do
    admin = FactoryGirl.create(:user, role: 'admin')
    company = FactoryGirl.create(:company, user_id: admin.id)
    CompanyUser.create(company_id: company.id, user_id: admin.id)
    sign_in_as(admin)

    visit new_company_department_path(company)
    fill_in 'Name', with: 'Clinton Group'
    click_on 'Submit'

    expect(page).to have_content('Department added successfully.')
    expect(page).to have_content('Clinton Group')
  end

  scenario 'admin tries to add blank form' do
    admin = FactoryGirl.create(:user, role: 'admin')
    company = FactoryGirl.create(:company, user_id: admin.id)
    CompanyUser.create(company_id: company.id, user_id: admin.id)
    sign_in_as(admin)

    visit new_company_department_path(company)
    click_on 'Submit'

    expect(page).to have_content("Name can't be blank")
  end

  scenario 'user tries to create a department' do
    user = FactoryGirl.create(:user)
    company = FactoryGirl.create(:company, user_id: user.id)
    CompanyUser.create(company_id: company.id, user_id: user.id)
    sign_in_as(user)

    visit new_company_department_path(company)
    expect(page).to have_content("You don't have access to this page!")
  end

  scenario 'visitor tries to create a department' do
    admin = FactoryGirl.create(:user, role: 'admin')
    company = FactoryGirl.create(:company, user_id: admin.id)

    visit new_company_department_path(company)
    expect(page).to have_content('You need to sign in or sign up before continuing.')
  end
end
