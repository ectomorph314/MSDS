require 'rails_helper'
require 'support/authentication_helper'

include AuthenticationHelper

feature 'admin deletes department', %{
  As an authenticated admin
  I want to delete a department
  So that my company doesn't read it
} do
  # Acceptance Criteria:
  #   Admin clicks to create a new company
  # 	Admin fills in a name (required, unique)
  # 	Admin submits form
  # 	Admin is redirected to company show page, if successful
  # 	Admin should be presented with form and errors, if unsuccessful

  scenario 'admin deletes a department' do
    admin = FactoryGirl.create(:user, role: 'admin')
    company = FactoryGirl.create(:company, user_id: admin.id)
    department = FactoryGirl.create(:department, company_id: company.id)
    CompanyUser.create(company_id: company.id, user_id: admin.id)
    sign_in_as(admin)

    visit company_department_path(company, department)
    click_on 'Delete Department'

    expect(page).to have_content('Department deleted.')
    expect(page).to_not have_content(department.name)
  end

  scenario 'user tries to delete a department' do
    user = FactoryGirl.create(:user)
    company = FactoryGirl.create(:company, user_id: user.id)
    department = FactoryGirl.create(:department, company_id: company.id)
    CompanyUser.create(company_id: company.id, user_id: user.id)
    sign_in_as(user)

    visit company_department_path(company, department)
    expect(page).to_not have_content('Delete Department')
  end
end
