require 'rails_helper'
require 'support/authentication_helper'

include AuthenticationHelper

feature 'admin edits a department', %{
  As an authenticated admin
  I want to edit a department
  So that I can fix or update information.
} do
  # Acceptance Criteria:
  #   Admin signs in and goes to department index page
  # 	Admin clicks to create new department
  # 	Admin can change the name
  # 	Admin submits form
  # 	Admin is redirected to department index page, if successful
  # 	Admin should be presented with form and errors, if unsuccessful

  scenario 'admin edits a department successfully' do
    admin = FactoryGirl.create(:user, role: 'admin')
    company = FactoryGirl.create(:company, user_id: admin.id)
    CompanyUser.create(company_id: company.id, user_id: admin.id)
    department = FactoryGirl.create(:department, company_id: company.id)
    sign_in_as(admin)

    visit edit_company_department_path(company, department)
    fill_in 'Name', with: 'Clinton Group'
    click_on 'Update'

    expect(page).to have_content('Department edited successfully.')
    expect(page).to have_content('Clinton Group')
  end

  scenario 'admin tries to change to a blank form' do
    admin = FactoryGirl.create(:user, role: 'admin')
    company = FactoryGirl.create(:company, user_id: admin.id)
    CompanyUser.create(company_id: company.id, user_id: admin.id)
    department = FactoryGirl.create(:department, company_id: company.id)
    sign_in_as(admin)

    visit edit_company_department_path(company, department)
    fill_in 'Name', with: ''
    click_on 'Update'

    expect(page).to have_content("Name can't be blank")
  end

  scenario 'user tries to edit a department' do
    user = FactoryGirl.create(:user)
    company = FactoryGirl.create(:company, user_id: user.id)
    CompanyUser.create(company_id: company.id, user_id: user.id)
    department = FactoryGirl.create(:department, company_id: company.id)
    sign_in_as(user)

    visit edit_company_department_path(company, department)
    expect(page).to have_content("You don't have access to this page!")
  end

  scenario 'visitor tries to edit a department' do
    admin = FactoryGirl.create(:user, role: 'admin')
    company = FactoryGirl.create(:company, user_id: admin.id)
    department = FactoryGirl.create(:department, company_id: company.id)

    visit edit_company_department_path(company, department)
    expect(page).to have_content('You need to sign in or sign up before continuing.')
  end
end
