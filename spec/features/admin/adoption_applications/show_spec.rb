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

  it "displays all pets on an application and there is a button to approve or deny the application for that pet" do
    visit "/admin/adoption_applications/#{@adoption_application1.id}"

    expect(page).to have_button("Approve #{@pet1.name}")
    expect(page).to have_button("Reject #{@pet1.name}")
    expect(page).to have_button("Approve #{@pet2.name}")
    expect(page).to have_button("Reject #{@pet2.name}")

    click_on("Approve #{@pet1.name}")

    expect(page).to have_current_path("/admin/adoption_applications/#{@adoption_application1.id}")
    expect(page).to_not have_content("Approve #{@pet1.name}")
    expect(page).to have_content("#{@pet1.name}:\nApproved")
  end

  it "allows an admin to approve a pet for that specific application" do
    visit "/admin/adoption_applications/#{@adoption_application1.id}"

    click_on("Approve #{@pet1.name}")

    expect(page).to have_current_path("/admin/adoption_applications/#{@adoption_application1.id}")
    expect(page).to_not have_content("Approve #{@pet1.name}")
    expect(page).to have_content("#{@pet1.name}:\nApproved")

    visit "/admin/adoption_applications/#{@adoption_application2.id}"

    expect(page).to have_button("Approve #{@pet1.name}")
    expect(page).to have_button("Reject #{@pet1.name}")
  end

  it "allows an admin to reject a pet for that specific application" do
    visit "/admin/adoption_applications/#{@adoption_application1.id}"

    click_on("Reject #{@pet1.name}")

    expect(page).to have_current_path("/admin/adoption_applications/#{@adoption_application1.id}")
    expect(page).to_not have_content("Reject #{@pet1.name}")
    expect(page).to have_content("#{@pet1.name}:\nRejected")

    visit "/admin/adoption_applications/#{@adoption_application2.id}"

    expect(page).to have_button("Approve #{@pet1.name}")
    expect(page).to have_button("Reject #{@pet1.name}")
  end
end
