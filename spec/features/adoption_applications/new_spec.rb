require "rails_helper"

RSpec.describe "the adoption application new" do
  it "has a form that can be filled with application details" do
    visit "/adoption_applications/new"
    fill_in(:name, with: "Billy Wallace")
    fill_in(:street_address, with: "321 Dog Lover St.")
    fill_in(:city, with: "Denver")
    fill_in(:state, with: "CO")
    fill_in(:zip_code, with: 80210)
    fill_in(:description, with: "I love dogs and want more.")
    click_button("Submit Application")
    
    expect(page).to have_current_path("/adoption_applications/#{AdoptionApplication.last.id}")

    expect(page).to have_content("Name: Billy Wallace")
    expect(page).to have_content("Address: 321 Dog Lover St. Denver, CO 80210")
    expect(page).to have_content("Description: I love dogs and want more.")
    expect(page).to have_content("Status: In Progress")
  end

  it "returns you to the form page if you fail to submit any of the form fields" do
    visit "/adoption_applications/new"
    fill_in(:name, with: "Billy Wallace")
    fill_in(:street_address, with: "321 Dog Lover St.")
    fill_in(:zip_code, with: 80210)
    fill_in(:description, with: "I love dogs and want more.")
    click_button("Submit Application")

    expect(page).to have_current_path("/adoption_applications/new")
    expect(page).to have_content("Error: City can't be blank, State can't be blank")
  end
end