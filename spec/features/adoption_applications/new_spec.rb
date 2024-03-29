require "rails_helper"

RSpec.describe "the adoption application new" do
  it "has a form that can be filled with application details" do
    visit "/adoption_applications/new"
    fill_in("Name", with: "Billy Wallace")
    fill_in("Street Address", with: "321 Dog Lover St.")
    fill_in("City", with: "Denver")
    fill_in("State", with: "CO")
    fill_in("Zip Code", with: 80210)
    fill_in("Description", with: "I love dogs and want more.")
    click_button("Submit Application")
    
    expect(page).to have_current_path("/adoption_applications/:id")

    expect(page).to have_content("Name: Billy Wallace")
    expect(page).to have_content("Address: 321 Dog Lover St. Denver, CO 80210")
    expect(page).to have_content("Description: I love dogs and want more.")
    expect(page).to have_content("Status: In Progress")
  end
end