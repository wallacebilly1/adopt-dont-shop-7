require "rails_helper"

RSpec.describe "the adoption application show page" do
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
    @adoption_application.pending

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
    @adoption_application.pending
    visit "/adoption_applications/#{@adoption_application.id}"

    expect(page).to have_link(@pet1.name)
    expect(page).to have_link(@pet2.name)

    click_link(@pet1.name)

    expect(page.current_path).to eq("/pets/#{@pet1.id}")
  end

  it "shows a section on the page to 'Add a Pet to this application' that can be used to search for pets" do
    visit "/adoption_applications/#{@adoption_application.id}"

    expect(page).to have_content("Add a Pet to this application")

    fill_in("name", with: "Lucille Bald")
    click_on("find pet")

    expect(page).to have_current_path(
      "/adoption_applications/#{@adoption_application.id}",
      ignore_query: true
    )
    expect(page).to have_button("Adopt")
  end

  it "can add a pet to the adoption application" do
    ApplicationPet.destroy_all

    visit "/adoption_applications/#{@adoption_application.id}?name=#{@pet1.name}"

    click_on("Adopt")

    expect(page).to have_content("Pets applied for:")

    expect(page).to have_link(@pet1.name)
  end

  it "displays an application submission section when a pet is added to the applicaton" do
    ApplicationPet.destroy_all

    visit "/adoption_applications/#{@adoption_application.id}?name=#{@pet1.name}"

    click_on("Adopt")

    expect(page).to have_content("Why would you make a good owner for these pet(s)")
    expect(page).to have_content("Submit your Application")
  end

  it "when an application is submitted, the user is returned to their application show page, their status is updated to pending, and the section to add more pets is no longer there" do
    ApplicationPet.destroy_all

    visit "/adoption_applications/#{@adoption_application.id}?name=#{@pet1.name}"

    click_on("Adopt")

    fill_in("details", with: "I am great with cats")

    click_on("Submit your Application")

    expect(page).to have_current_path("/adoption_applications/#{@adoption_application.id}")

    expect(page).to have_content("Status: Pending")
    expect(page).to_not have_content("Add a Pet to this application")
  end
end
