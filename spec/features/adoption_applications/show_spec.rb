require "rails_helper"

RSpec.describe "the adoption application show" do
  before(:each) do
    @adoption_application = AdoptionApplication.create!(
      name: "Billy Neilson",
      street_address: "123 Main St",
      city: "Denver",
      state: "CO",
      zip_code: "80210",
      description: "I like doggos"
    )
    @shelter = Shelter.create(
      name: "Aurora shelter",
      city: "Aurora, CO",
      foster_program: false,
      rank: 9
    )
    @pet1 = Pet.create(
      adoptable: true,
      age: 1,
      breed: "sphynx",
      name: "Lucille Bald",
      shelter_id: @shelter.id
    )
    @pet2 = Pet.create(
      adoptable: true,
      age: 3,
      breed: "doberman",
      name: "Lobster",
      shelter_id: @shelter.id
    )
    @application_pet1 = ApplicationPet.create!(
      pet_id: @pet1.id,
      adoption_application_id: @adoption_application.id
    )
    @application_pet2 = ApplicationPet.create!(
      pet_id: @pet2.id,
      adoption_application_id: @adoption_application.id
    )
  end

  it "shows the adoption application and all its attributes" do
    visit "/adoption_applications/#{@adoption_application.id}"

    expect(page).to have_content(@adoption_application.name)
    expect(page).to have_content(@adoption_application.street_address)
    expect(page).to have_content(@adoption_application.city)
    expect(page).to have_content(@adoption_application.state)
    expect(page).to have_content(@adoption_application.zip_code)
    expect(page).to have_content(@adoption_application.description)
    expect(page).to have_content(@adoption_application.status)
    expect(page).to have_content(@pet1.name)
    expect(page).to have_content(@pet2.name)
  end

  it "has links to the pets' show pages" do
    visit "/adoption_applications/#{@adoption_application.id}"

    expect(page).to have_link(@pet1.name)
    expect(page).to have_link(@pet2.name)

    click_link(@pet1.name)

    expect(page.current_path).to eq("/pets/#{@pet1.id}")
  end

  it "shows a section on the page to 'Add a Pet to this application' that can be used to search for pets" do
    visit "/adoption_applications/#{@adoption_application.id}"

    expect(page).to have_content("Add a Pet to this application")

    within "add a pet..." do
      fill_in("add a pet").with("sphynx")
      click_on("submit")
    end

    expect(page).to have_current_path("/adoption_applications/#{@adoption_application.id}")
    expect(page).to have_link("sphynx")
  end
end
