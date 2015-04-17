require 'rails_helper'
require 'support/authentication_helper'

include AuthenticationHelper

feature 'admin edits a data sheet', %{
  As an authenticated admin
  I want to edit a data sheet
  So that others can see the most up-to-date information.
} do
  # Acceptance Criteria:
  #   Admin signs in and goes to company show page
  # 	Admin clicks to create new data sheet
  # 	Admin fills in a name (required)
  #   Admin fills in description (optional)
  # 	Admin adds a pdf file (required)
  # 	Admin submits form
  # 	Admin is redirected to data sheet index page, if successful
  # 	Admin should be presented with form and errors, if unsuccessful

  scenario 'admin edits a data sheet successfully' do
    user = FactoryGirl.create(:user)
    company = FactoryGirl.create(:company, user_id: user.id)
    data_sheet = FactoryGirl.create(:data_sheet, company_id: company.id)
    sign_in_as(user)

    visit edit_company_data_sheet_path(company.id, data_sheet.id)
    fill_in 'Name', with: 'Borosilicate'
    fill_in 'Description', with: 'Standard Glass'
    click_button 'Update'

    expect(page).to have_content('Borosilicate')
    expect(page).to have_content('Standard Glass')
  end

  scenario 'admin tries to add blank form' do
    user = FactoryGirl.create(:user)
    company = FactoryGirl.create(:company, user_id: user.id)
    data_sheet = FactoryGirl.create(:data_sheet, company_id: company.id)
    sign_in_as(user)

    visit edit_company_data_sheet_path(company.id, data_sheet.id)
    fill_in 'Name', with: ''
    click_button 'Update'

    expect(page).to have_content("Name can't be blank")
  end

  scenario 'visitor tries to edit a datasheet' do
    user = FactoryGirl.create(:user)
    company = FactoryGirl.create(:company, user_id: user.id)
    data_sheet = FactoryGirl.create(:data_sheet, company_id: company.id)

    visit edit_company_data_sheet_path(company.id, data_sheet.id)
    expect(page).to have_content('You need to sign in or sign up before continuing.')
  end
end
