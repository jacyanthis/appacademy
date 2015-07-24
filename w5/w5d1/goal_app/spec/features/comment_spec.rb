require 'spec_helper'
require 'rails_helper'

feature "commenting on users" do
  let!(:user) { create(:user) }

  before(:each) do
    visit new_session_url
    fill_in 'username', with: user.username
    fill_in 'password', with: user.password
    click_on 'Sign in'
  end

  it "has a new comment form on the user show page" do
    visit user_url(user)
    expect(page).to have_content("New Comment")
  end

  it "shows the comment upon submission on the user show page" do
    visit user_url(user)
    fill_in "Body", with: "This is a test comment."
    click_on "Make Comment"
    expect(page).to have_content("This is a test comment.")
  end
end

feature "commenting on goals" do
  let!(:user) { create(:user) }
  let!(:public_goal) { create(:public_goal, user: user) }

  before(:each) do
    visit new_session_url
    fill_in 'username', with: user.username
    fill_in 'password', with: user.password
    click_on 'Sign in'
  end

  it "has a new comment form on the goal show page" do
    visit goal_url(public_goal)
    expect(page).to have_content("New Comment")
  end

  it "shows the comment upon submission on the goal show page" do
    visit goal_url(public_goal)
    fill_in "Body", with: "This is a test comment."
    click_on "Make Comment"
    expect(page).to have_content("This is a test comment.")
  end
end
