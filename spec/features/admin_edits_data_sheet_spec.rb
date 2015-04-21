require 'rails_helper'
require 'support/authentication_helper'

include AuthenticationHelper

feature 'admin edits a data sheet', %{
  As an authenticated admin
  I want to edit a data sheet
  So that others can see the most up-to-date information.
} do
  # Acceptance Criteria:
  #   Admin signs in and goes to data sheet index page
  # 	Admin clicks to edit a data sheet
  # 	Admin fills in a name (required)
  #   Admin fills in description (optional)
  # 	Admin submits form
  # 	Admin is redirected to data sheet index page, if successful
  # 	Admin should be presented with form and errors, if unsuccessful

  scenario 'admin edits a data sheet successfully' do
    admin = FactoryGirl.create(:user, role: 'admin')
    company = FactoryGirl.create(:company, user_id: admin.id)
    data_sheet = FactoryGirl.create(:data_sheet, company_id: company.id)
    CompanyUser.create(company_id: company.id, user_id: admin.id)
    sign_in_as(admin)

    visit edit_company_data_sheet_path(company, data_sheet)
    fill_in 'Number', with: '42537426845'
    fill_in 'Name', with: 'Borosilicate'
    click_on 'Update'

    expect(page).to have_content('Data sheet edited successfully.')
    expect(page).to have_content('42537426845')
    expect(page).to have_content('Borosilicate')
  end

  scenario 'admin tries to add blank form' do
    admin = FactoryGirl.create(:user, role: 'admin')
    company = FactoryGirl.create(:company, user_id: admin.id)
    data_sheet = FactoryGirl.create(:data_sheet, company_id: company.id)
    CompanyUser.create(company_id: company.id, user_id: admin.id)
    sign_in_as(admin)

    visit edit_company_data_sheet_path(company, data_sheet)
    fill_in 'Number', with: ''
    fill_in 'Name', with: ''
    click_on 'Update'

    expect(page).to have_content("Number can't be blank")
    expect(page).to have_content("Name can't be blank")
  end

  scenario 'visitor tries to edit a data sheet' do
    user = FactoryGirl.create(:user)
    company = FactoryGirl.create(:company, user_id: user.id)
    data_sheet = FactoryGirl.create(:data_sheet, company_id: company.id)

    visit edit_company_data_sheet_path(company, data_sheet)
    expect(page).to have_content('You need to sign in or sign up before continuing.')
  end
end
