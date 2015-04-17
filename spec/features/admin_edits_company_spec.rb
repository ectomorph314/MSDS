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

  scenario 'admin edits a company successfully' do
    user = FactoryGirl.create(:user)
    company = FactoryGirl.create(:company, user_id: user.id)
    sign_in_as(user)

    visit edit_company_path(company.id)
    fill_in 'Name', with: 'Launch Academy'
    click_button 'Update'

    expect(page).to have_content('Company edited successfully.')
    expect(page).to have_content('Launch Academy')
  end

  scenario 'admin tries to edit a company to a blank name' do
    user = FactoryGirl.create(:user)
    company = FactoryGirl.create(:company, user_id: user.id)
    sign_in_as(user)

    visit edit_company_path(company.id)
    fill_in 'Name', with: ''
    click_button 'Update'

    expect(page).to have_content("Name can't be blank")
  end

  scenario 'admin tries to edit a company to a non-unique name' do
    user = FactoryGirl.create(:user)
    company1 = FactoryGirl.create(:company, user_id: user.id)
    company2 = FactoryGirl.create(:company, user_id: user.id)
    sign_in_as(user)

    visit edit_company_path(company1.id)
    fill_in 'Name', with: 'Launch Academy'
    click_button 'Update'

    visit edit_company_path(company2.id)
    fill_in 'Name', with: 'Launch Academy'
    click_button 'Update'

    expect(page).to have_content('Name has already been taken')
  end

  scenario 'visitor tries to edit a company' do
    user = FactoryGirl.create(:user)
    company = FactoryGirl.create(:company, user_id: user.id)

    visit edit_company_path(company.id)
    expect(page).to have_content('You need to sign in or sign up before continuing.')
  end
end
