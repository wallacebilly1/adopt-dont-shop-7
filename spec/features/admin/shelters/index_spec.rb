require "rails_helper"

RSpec.describe "the admin shelters display page" do
  before(:each) do
    @adoption_application1 = AdoptionApplication.create!(
      name: "Billy Neilson",
      street_address: "123 Main St",
      city: "Denver",
      state: "CO",
      zip_code: "80210",
      description: "I like doggos",
      status: "In Progress"
    )
    @adoption_application2 = AdoptionApplication.create!(
      name: "Neilly Billson",
      street_address: "125 Other St",
      city: "Boulder",
      state: "CO",
      zip_code: "80999",
      description: "I like kittehs",
      status: "In Progress"
    )
    @adoption_application3 = AdoptionApplication.create!(
      name: "Tom Cruise",
      street_address: "Beverly Hills Ave",
      city: "Boulder",
      state: "CO",
      zip_code: "80303",
      description: "YEAAAAAAAHHHHHHH",
      status: "In Progress"
    )
    @shelter1 = Shelter.create!(
      name: "Boulder shelter",
      city: "Boulder, CO",
      foster_program: true,
      rank: 5
    )
    @shelter2 = Shelter.create!(
      name: "Aurora shelter",
      city: "Aurora, CO",
      foster_program: false,
      rank: 9
    )
    @shelter3 = Shelter.create!(
      name: "Loveland shelter",
      city: "Loveland, CO",
      foster_program: true,
      rank: 8
    )
    @pet1 = Pet.create(
      adoptable: true,
      age: 1,
      breed: "sphynx",
      name: "Lucille Bald",
      shelter_id: @shelter1.id
    )
    @pet2 = Pet.create(
      adoptable: true,
      age: 3,
      breed: "doberman",
      name: "Lobster",
      shelter_id: @shelter1.id
    )
    @pet3 = Pet.create(
      adoptable: true,
      age: 3,
      breed: "west highland white terrier",
      name: "Mitzi",
      shelter_id: @shelter2.id
    )
    @pet4 = Pet.create(
      adoptable: true,
      age: 3,
      breed: "black labrador retriever",
      name: "Doofus",
      shelter_id: @shelter2.id
    )
    @pet5 = Pet.create(
      adoptable: true,
      age: 3,
      breed: "pitbull",
      name: "Biff",
      shelter_id: @shelter3.id
    )
    @adoption_application1.adopt(@pet1)
    @adoption_application1.adopt(@pet2)
    @adoption_application2.adopt(@pet1)
    @adoption_application2.adopt(@pet3)
    @adoption_application3.adopt(@pet2)
    @adoption_application3.adopt(@pet4)
  end

  it "shows all shelters listed in reverse alphabetical order by nane" do
    visit "/admin/shelters"

    expect("Loveland shelter").to appear_before("Boulder shelter")
    expect("Boulder shelter").to appear_before("Aurora shelter")
  end

  it "shows shelters with pending applications" do
    visit "/admin/shelters"

    within ".pending-applications" do
      expect(page).to have_content(@shelter1.name)
      expect(page).to have_content(@shelter2.name)
      expect(page).to_not have_content(@shelter3.name)
    end

    within "#shelter-#{@shelter1.id}" do
      expect(page).to have_content(@adoption_application1.name)
      expect(page).to have_content(@adoption_application1.street_address)
      expect(page).to have_content(@adoption_application1.city)
      expect(page).to have_content(@adoption_application1.state)
      expect(page).to have_content(@adoption_application1.zip_code)
      expect(page).to have_content(@adoption_application1.description)
      expect(page).to have_content(@adoption_application2.name)
      expect(page).to have_content(@adoption_application2.street_address)
      expect(page).to have_content(@adoption_application2.city)
      expect(page).to have_content(@adoption_application2.state)
      expect(page).to have_content(@adoption_application2.zip_code)
      expect(page).to have_content(@adoption_application2.description)
      expect(page).to have_content(@adoption_application3.name)
      expect(page).to have_content(@adoption_application3.street_address)
      expect(page).to have_content(@adoption_application3.city)
      expect(page).to have_content(@adoption_application3.state)
      expect(page).to have_content(@adoption_application3.zip_code)
      expect(page).to have_content(@adoption_application3.description)
    end

    within "#shelter-#{@shelter2.id}" do
      expect(page).to_not have_content(@adoption_application1.name)
      expect(page).to_not have_content(@adoption_application1.street_address)
      expect(page).to_not have_content(@adoption_application1.zip_code)
      expect(page).to_not have_content(@adoption_application1.description)
      expect(page).to have_content(@adoption_application2.name)
      expect(page).to have_content(@adoption_application2.street_address)
      expect(page).to have_content(@adoption_application2.city)
      expect(page).to have_content(@adoption_application2.state)
      expect(page).to have_content(@adoption_application2.zip_code)
      expect(page).to have_content(@adoption_application2.description)
      expect(page).to have_content(@adoption_application3.name)
      expect(page).to have_content(@adoption_application3.street_address)
      expect(page).to have_content(@adoption_application3.city)
      expect(page).to have_content(@adoption_application3.state)
      expect(page).to have_content(@adoption_application3.zip_code)
      expect(page).to have_content(@adoption_application3.description)
    end
  end
end
