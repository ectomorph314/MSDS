require 'rails_helper'
require 'support/authentication_helper'

include AuthenticationHelper

feature 'owner views company list', %{
  As the owner of the app
  I want to view the list of companies
  So that I can know who is using my app
} do
  # Acceptance Criteria:
  #   Owner visits the company index page
  # 	Owner sees list of company names

  scenario 'owner views company list' do
    user = FactoryGirl.create(:user)
    company = FactoryGirl.create(:company, user_id: user.id)
    sign_in_as(user)

    visit companies_path
    expect(page).to have_content(company.name)
  end

  scenario 'visitor tries to view company list' do
    visit companies_path
    expect(page).to have_content('You need to sign in or sign up before continuing.')
  end
end
