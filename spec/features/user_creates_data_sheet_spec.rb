require 'rails_helper'
require 'support/authentication_helper'

include AuthenticationHelper

feature 'user creates new data sheet', %{
  As an authenticated user
  I want to add a data sheet
  So that others can read it and be safe.
} do
  # Acceptance Criteria:
  #   User signs in and goes to company show page
  # 	User clicks to create new data sheet
  # 	User fills in a name (required)
  #   User fills in description (optional)
  # 	User adds a pdf file (required)
  # 	User submits form
  # 	User is redirected to data sheet index page, if successful
  # 	User should be presented with form and errors, if unsuccessful

  scenario 'user adds valid data sheet' do
    user = FactoryGirl.create(:user)
    company = FactoryGirl.create(:company, user_id: user.id)
    sign_in_as(user)

    visit new_company_data_sheet_path(company.id)
    fill_in 'Name', with: 'Borosilicate'
    fill_in 'Description', with: 'Standard Glass'
    attach_file('Safety Data Sheet', "#{Rails.root}/spec/fixtures/OSHA3514.pdf")
    click_button 'Submit'

    expect(page).to have_content('Borosilicate')
    expect(page).to have_content('Standard Glass')
  end

  scenario 'user tries to add blank form' do
    user = FactoryGirl.create(:user)
    company = FactoryGirl.create(:company, user_id: user.id)
    sign_in_as(user)

    visit new_company_data_sheet_path(company.id)
    click_button 'Submit'

    expect(page).to have_content("Name can't be blank")
    expect(page).to have_content("Sds can't be blank")
  end

  scenario 'user tries to add blank form' do
    user = FactoryGirl.create(:user)
    company = FactoryGirl.create(:company, user_id: user.id)
    sign_in_as(user)

    visit new_company_data_sheet_path(company.id)
    attach_file('Safety Data Sheet', "#{Rails.root}/spec/fixtures/OSHA3514.jpg")
    click_button 'Submit'

    expect(page).to have_content("Sds You are not allowed to upload")
    expect(page).to have_content("files, allowed types: pdf")
  end

  scenario 'visitor tries to add company' do
    user = FactoryGirl.create(:user)
    company = FactoryGirl.create(:company, user_id: user.id)

    visit new_company_data_sheet_path(company.id)
    expect(page).to have_content('You need to sign in or sign up before continuing.')
  end
end
