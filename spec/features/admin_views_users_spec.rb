require 'rails_helper'
require 'support/authentication_helper'

include AuthenticationHelper

feature 'admin views users', %{
  As an authenticated admin
  I want to view a list of users in my company
  So that I can keep track of them
} do
  # Acceptance Criteria:
  #   Admin visits the user index page
  #   Admin can see user email and company

  scenario 'owner views list of users' do
    owner = FactoryGirl.create(:user, role: 'owner')
    sign_in_as(owner)

    user1 = FactoryGirl.create(:user)
    company1 = FactoryGirl.create(:company, user_id: user1.id)
    CompanyUser.create(company_id: company1.id, user_id: user1.id)

    user2 = FactoryGirl.create(:user)
    company2 = FactoryGirl.create(:company, user_id: user2.id)
    CompanyUser.create(company_id: company2.id, user_id: user2.id)

    user3 = FactoryGirl.create(:user)

    visit users_path
    expect(page).to have_content(owner.email)
    expect(page).to have_content(user1.email)
    expect(page).to have_content(user2.email)
    expect(page).to have_content(user3.email)
  end

  scenario 'admin views list of users' do
    admin = FactoryGirl.create(:user, role: 'admin')
    company1 = FactoryGirl.create(:company, user_id: admin.id)
    CompanyUser.create(company_id: company1.id, user_id: admin.id)
    sign_in_as(admin)

    user1 = FactoryGirl.create(:user)
    CompanyUser.create(company_id: company1.id, user_id: user1.id)

    user2 = FactoryGirl.create(:user)
    company2 = FactoryGirl.create(:company, user_id: user2.id)
    CompanyUser.create(company_id: company2.id, user_id: user2.id)

    user3 = FactoryGirl.create(:user)

    visit users_path
    expect(page).to have_content(admin.email)
    expect(page).to have_content(user1.email)
    expect(page).to_not have_content(user2.email)
    expect(page).to have_content(user3.email)
  end

  scenario 'user tries to view user list' do
    user = FactoryGirl.create(:user)
    sign_in_as(user)

    visit users_path
    expect(page).to have_content("You don't have access to this page!")
  end

  scenario 'visitor tries to view user list' do
    visit users_path
    expect(page).to have_content('You need to sign in or sign up before continuing.')
  end
end
