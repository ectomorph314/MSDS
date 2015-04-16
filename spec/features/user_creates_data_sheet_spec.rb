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
    attach_file('Safety Data Sheet', "#{Rails.root}/spec/fixtures/Stonehenge.pdf")
    click_button 'Submit'

    expect(page).to have_content('Borosilicate')
    expect(page).to have_content('Standard Glass')
  end
end
