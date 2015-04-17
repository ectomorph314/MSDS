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
    user = FactoryGirl.create(:user)
    sign_in_as(user)

    visit new_company_path
    fill_in 'Name', with: 'Launch Academy'
    click_button 'Submit'

    expect(page).to have_content('Company added successfully.')
    expect(page).to have_content('Launch Academy')
  end

  scenario 'admin tries to add company with blank name' do
    user = FactoryGirl.create(:user)
    sign_in_as(user)

    visit new_company_path
    click_button 'Submit'

    expect(page).to have_content("Name can't be blank")
  end

  scenario 'admin tries to add company with non-unique name' do
    user = FactoryGirl.create(:user)
    sign_in_as(user)

    visit new_company_path
    fill_in 'Name', with: 'Launch Academy'
    click_button 'Submit'

    visit new_company_path
    fill_in 'Name', with: 'Launch Academy'
    click_button 'Submit'

    expect(page).to have_content('Name has already been taken')
  end

  scenario 'visitor tries to add company' do
    visit new_company_path
    expect(page).to have_content('You need to sign in or sign up before continuing.')
  end
end
