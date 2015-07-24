require 'spec_helper'
require 'rails_helper'

feature "the goal creation process" do
  let!(:user) { create(:user) }

  before(:each) do
    visit new_session_url
    fill_in 'username', with: user.username
    fill_in 'password', with: user.password
    click_on 'Sign in'
  end

  it "has a new goal page" do
    visit new_goal_url
    expect(page).to have_content "New Goal"
  end

  feature "creating a new goal" do
    it "redirects to the user's profile after submitting new goal" do
      visit new_goal_url
      fill_in 'Description', with: "Yet another bucket list item."
      click_on "Create Goal"

      expect(page).to have_content "testing_username's Profile"
    end

    it "displays the goal on the goal page" do
      visit new_goal_url
      fill_in 'Description', with: "Yet another bucket list item."
      click_on "Create Goal"

      expect(page).to have_content "Yet another bucket list item."
    end

    it "rejects a goal with no description" do
      visit new_goal_url
      click_on "Create Goal"

      expect(page).to have_content "Description can't be blank"
    end
  end

  feature "displaying new goal" do
    let!(:other_user) { create(:other_user) }
    let!(:public_goal) { create(:public_goal, user: user) }
    let!(:private_goal) { create(:private_goal, user: user) }
    let!(:other_private_goal) { create(:other_private_goal, user: other_user) }
    let!(:other_public_goal) { create(:other_public_goal, user: other_user) }

    it "shows all the user's own goals on user profile" do
      visit user_url(user)

      expect(page).to have_content public_goal.description
      expect(page).to have_content private_goal.description
    end

    it "shows exclusively public goals of other users" do
      visit user_url(other_user)
      expect(page).to have_content other_public_goal.description
      expect(page).not_to have_content other_private_goal.description
    end

    it "shows exclusively public goals in general index" do
      visit goals_url
      expect(page).to have_content public_goal.description
      expect(page).not_to have_content private_goal.description
      expect(page).to have_content other_public_goal.description
      expect(page).not_to have_content other_private_goal.description
    end
  end
end

feature "the goal deletion process" do
  let!(:public_goal) {create(:public_goal)}
  it "successfully deletes a goal" do
    public_goal.destroy
    visit goals_url
    expect(page).not_to have_content public_goal.description
  end
end

# feature "the goal completion process" do
#   create(:user)
#   create(:completed_goal)
#   create(:uncompleted_goal)
#   visit(user_url(user))
#
#   it "shows a completed goal" do
#     expect(page).to have_content
#   end
#
#   it "shows an uncompleted goal" do
#
#   end
# end
