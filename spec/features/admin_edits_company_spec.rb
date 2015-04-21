require 'rails_helper'
require 'support/authentication_helper'

include AuthenticationHelper

feature 'admin edits company', %{
  As an authenticated admin
  I want to edit my company
  So that I can change incorrect information
} do
  # Acceptance Criteria:
  #   Admin clicks to edit company
  # 	Admin fills in a name (required, unique)
  # 	Admin submits form
  # 	Admin is redirected to company show page, if successful
  # 	Admin should be presented with form and errors, if unsuccessful

  scenario 'admin edits a company successfully' do
    admin = FactoryGirl.create(:user, role: 'admin')
    company = FactoryGirl.create(:company, user_id: admin.id)
    CompanyUser.create(company_id: company.id, user_id: admin.id)
    sign_in_as(admin)

    visit edit_company_path(company)
    fill_in 'Name', with: 'Launch Academy'
    click_on 'Update'

    expect(page).to have_content('Company edited successfully.')
    expect(page).to have_content('Launch Academy')
  end

  scenario 'admin tries to edit a company to a blank name' do
    admin = FactoryGirl.create(:user, role: 'admin')
    company = FactoryGirl.create(:company, user_id: admin.id)
    CompanyUser.create(company_id: company.id, user_id: admin.id)
    sign_in_as(admin)

    visit edit_company_path(company)
    fill_in 'Name', with: ''
    click_on 'Update'

    expect(page).to have_content("Name can't be blank")
  end

  scenario 'admin tries to edit a company to a non-unique name' do
    admin = FactoryGirl.create(:user, role: 'admin')
    company = FactoryGirl.create(:company, user_id: admin.id)
    FactoryGirl.create(:company, name: 'Launch Academy', user_id: admin.id)
    CompanyUser.create(company_id: company.id, user_id: admin.id)
    sign_in_as(admin)

    visit edit_company_path(company)
    fill_in 'Name', with: 'Launch Academy'
    click_on 'Update'

    expect(page).to have_content('Name has already been taken')
  end

  scenario 'user tries to edit a company' do
    admin = FactoryGirl.create(:user, role: 'admin')
    company = FactoryGirl.create(:company, user_id: admin.id)
    user = FactoryGirl.create(:user)
    CompanyUser.create(company_id: company.id, user_id: user.id)
    sign_in_as(user)

    visit edit_company_path(company)
    expect(page).to have_content("You don't have access to this page!")
  end

  scenario 'visitor tries to edit a company' do
    user = FactoryGirl.create(:user)
    company = FactoryGirl.create(:company, user_id: user.id)

    visit edit_company_path(company)
    expect(page).to have_content('You need to sign in or sign up before continuing.')
  end
end
