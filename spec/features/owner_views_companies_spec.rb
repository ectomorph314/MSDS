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
  #   Admins, members, and visitors should be redirected

  scenario 'owner views company list' do
    owner = FactoryGirl.create(:user, role: 'owner')
    company = FactoryGirl.create(:company, user_id: owner.id)
    sign_in_as(owner)

    visit companies_path
    expect(page).to have_content(company.name)
  end

  scenario 'admin tries to view company list' do
    admin = FactoryGirl.create(:user, role: 'admin')
    sign_in_as(admin)

    visit companies_path
    expect(page).to have_content("You don't have access to this page!")
  end

  scenario 'user tries to view company list' do
    user = FactoryGirl.create(:user)
    sign_in_as(user)

    visit companies_path
    expect(page).to have_content("You don't have access to this page!")
  end

  scenario 'visitor tries to view company list' do
    visit companies_path
    expect(page).to have_content('You need to sign in or sign up before continuing.')
  end
end
