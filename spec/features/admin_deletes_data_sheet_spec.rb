require 'rails_helper'
require 'support/authentication_helper'

include AuthenticationHelper

feature 'admin deletes data_sheet', %{
  As an authenticated admin
  I want to delete a data_sheet
  So that my company doesn't read it
} do
  # Acceptance Criteria:
  #   Admin clicks to create a new company
  # 	Admin fills in a name (required, unique)
  # 	Admin submits form
  # 	Admin is redirected to company show page, if successful
  # 	Admin should be presented with form and errors, if unsuccessful

  scenario 'admin deletes a data sheet' do
    user = FactoryGirl.create(:user)
    company = FactoryGirl.create(:company, user_id: user.id)
    data_sheet = FactoryGirl.create(:data_sheet, company_id: company.id)
    sign_in_as(user)

    visit company_data_sheets_path(company)
    click_on 'Delete Data Sheet'

    expect(page).to have_content('Data sheet deleted.')
    expect(page).to_not have_content(data_sheet.name)
  end
end
