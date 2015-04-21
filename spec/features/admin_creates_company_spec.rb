require 'rails_helper'
require 'support/authentication_helper'

include AuthenticationHelper

feature 'admin creates new company', %{
  As an authenticated admin
  I want to create my company
  So that I can add safety data sheets to it
} do
  # Acceptance Criteria:
  #   Admin clicks to create a new company
  # 	Admin fills in a name (required, unique)
  # 	Admin submits form
  # 	Admin is redirected to company show page, if successful
  # 	Admin should be presented with form and errors, if unsuccessful

  scenario 'admin adds a valid company' do
    admin = FactoryGirl.create(:user, role: 'admin')
    sign_in_as(admin)

    visit new_company_path
    fill_in 'Name', with: 'Launch Academy'
    click_on 'Submit'

    expect(page).to have_content('Company added successfully.')
    expect(page).to have_content('Launch Academy')
  end

  scenario 'admin tries to add company with blank name' do
    admin = FactoryGirl.create(:user, role: 'admin')
    sign_in_as(admin)

    visit new_company_path
    click_on 'Submit'

    expect(page).to have_content("Name can't be blank")
  end

  scenario 'admin tries to add company with non-unique name' do
    admin1 = FactoryGirl.create(:user, role: 'admin')
    admin2 = FactoryGirl.create(:user, role: 'admin')
    FactoryGirl.create(:company, name: 'Launch Academy', user_id: admin1.id)
    sign_in_as(admin2)

    visit new_company_path
    fill_in 'Name', with: 'Launch Academy'
    click_on 'Submit'

    expect(page).to have_content('Name has already been taken')
  end

  scenario 'admin tries to create a second company' do
    admin = FactoryGirl.create(:user, role: 'admin')
    company = FactoryGirl.create(:company, user_id: admin.id)
    CompanyUser.create(company_id: company.id, user_id: admin.id)
    sign_in_as(admin)

    visit new_company_path
    expect(page).to have_content("You don't have access to this page!")
  end

  scenario 'user tries to create a company' do
    user = FactoryGirl.create(:user)
    sign_in_as(user)

    visit new_company_path
    expect(page).to have_content("You don't have access to this page!")
  end

  scenario 'visitor tries to create a company' do
    visit new_company_path
    expect(page).to have_content('You need to sign in or sign up before continuing.')
  end
end
