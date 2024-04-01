require "rails_helper"

RSpec.describe ApplicationShelter, type: :model do
  describe "relationships" do
    it { should belong_to(:adoption_application) }
    it { should belong_to(:shelter) }
  end

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

  it "can list shelters with pending applications" do
    expect(ApplicationShelter.shelters_with_pending_applications).to eq({
      @shelter1 => [
        @adoption_application1,
        @adoption_application2,
        @adoption_application3
      ],
      @shelter2 => [
        @adoption_application2,
        @adoption_application3
      ]
    })
  end
end
