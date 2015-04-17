require 'rails_helper'
require 'support/authentication_helper'

include AuthenticationHelper

feature 'admin deletes company', %{
  As an authenticated admin
  I want to delete my company
  So that my company doesn't use the app
} do
  # Acceptance Criteria:
  #   Admin clicks to create a new company
  # 	Admin fills in a name (required, unique)
  # 	Admin submits form
  # 	Admin is redirected to company show page, if successful
  # 	Admin should be presented with form and errors, if unsuccessful

  scenario 'admin adds a valid company' do
    user = FactoryGirl.create(:user)
    company = FactoryGirl.create(:company, user_id: user.id)
    sign_in_as(user)

    visit company_path(company)
    click_on 'Delete Company'

    expect(page).to have_content('Company deleted.')
    expect(page).to_not have_content(company.name)
  end
end
