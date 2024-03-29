require "rails_helper"

RSpec.describe "the adoption application show" do
  it "shows the adoption application and all its attributes" do
    adoption_application = AdoptionApplication.create!(
      name: "Billy Neilson",
      street_address: "123 Main St",
      city: "Denver",
      state: "CO",
      zip_code: "80210",
      description: "I like doggos",
      status: "in progress"
    )

    visit "/adoption_applications/#{adoption_application.id}"

    expect(page).to have_content(adoption_application.name)
    expect(page).to have_content(adoption_application.street_address)
    expect(page).to have_content(adoption_application.city)
    expect(page).to have_content(adoption_application.state)
    expect(page).to have_content(adoption_application.zip_code)
    expect(page).to have_content(adoption_application.description)
    expect(page).to have_content(adoption_application.status)
  end
end
