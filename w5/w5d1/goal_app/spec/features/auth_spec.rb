require 'spec_helper'
require 'rails_helper'

feature "the signup process" do

  it "has a new user page" do
    visit new_user_url
    expect(page).to have_content "New user"
  end

  feature "signing up a new user" do
    before(:each) do
      visit new_user_url
      fill_in 'username', with: "testing_username"
      fill_in 'password', with: "biscuits"
      click_on "Create User"
    end

    scenario "shows username on the index page after signup" do
      expect(page).to have_content "testing_username"
    end

    scenario "shows username on the index page after signup" do
      expect(page).to have_content "Goals"
    end

  end

end

feature "logging in" do

  before(:each) do
    create(:user)
  end

  it "logs in the user when given the correct credentials" do
    visit new_session_url
    fill_in 'username', with: 'testing_username'
    fill_in 'password', with: 'biscuits'
    click_on 'Sign in'

    expect(page).to have_content "Goals"
  end

  scenario "rejects a user with invalid password" do
    visit new_session_url
    fill_in 'username', with: 'testing_username'
    fill_in 'password', with: 'this_is_wrong'
    click_on 'Sign in'

    expect(page).to have_content "Invalid username or password."
    expect(page).not_to have_content "Goals"
  end

  scenario "rejects a user with invalid username" do
    visit new_session_url
    fill_in 'username', with: 'this_is_wrong'
    fill_in 'password', with: "doesn't matter"
    click_on 'Sign in'

    expect(page).to have_content "Invalid username or password."
    expect(page).not_to have_content "Goals"
  end

end

feature "logging out" do

  it "begins with logged out state" do
    visit(root_url)

    expect(page).to have_content "Sign in"
    expect(page).to have_content "Sign up"
  end

  it "doesn't show username on the homepage after logout" do
    visit new_user_url
    fill_in 'username', with: "testing_username"
    fill_in 'password', with: "biscuits"
    click_on "Create User"
    click_on "Sign out"

    expect(page).not_to have_content "testing_username"
  end

end
