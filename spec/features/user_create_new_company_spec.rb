require 'rails_helper'

feature 'user creates new company', %{
  As an authenticated user
  I want to create my company
  So that I can add safety data sheets to it
} do
  # Acceptance Criteria:
  #   User clicks to create a new company
  # 	User fills in a name (required, unique)
  # 	User submits form
  # 	User is redirected to company show page, if successful
  # 	User should be presented with form and errors, if unsuccessful

  scenario 'valid company' do
    user = FactoryGirl.create(:user)

    visit new_user_session_path
    fill_in 'Email', with: user.email
    fill_in 'Password', with: user.password
    click_button 'Log in'

    visit new_company_path
    fill_in 'Name', with: 'Launch Academy'
    click_button 'Submit'

    expect(page).to have_content('Company added successfully.')
    expect(page).to have_content('Launch Academy')
  end

  scenario 'blank name' do
    user = FactoryGirl.create(:user)

    visit new_user_session_path
    fill_in 'Email', with: user.email
    fill_in 'Password', with: user.password
    click_button 'Log in'

    visit new_company_path
    click_button 'Submit'

    expect(page).to have_content("Name can't be blank")
  end

  scenario 'non-unique name' do
    user = FactoryGirl.create(:user)

    visit new_user_session_path
    fill_in 'Email', with: user.email
    fill_in 'Password', with: user.password
    click_button 'Log in'

    visit new_company_path
    fill_in 'Name', with: 'Launch Academy'
    click_button 'Submit'

    visit new_company_path
    fill_in 'Name', with: 'Launch Academy'
    click_button 'Submit'

    expect(page).to have_content('Name has already been taken')
  end
end
