require "rails_helper"

RSpec.describe AdoptionApplication, type: :model do
  before(:each) do
    @application = AdoptionApplication.create!(
      name: "Jeffy Longstockings",
      street_address: "12613 War Admiral Ln",
      city: "Potomac",
      state: "MD",
      zip_code: "20904",
      description: "I have a nice house"
    )
    @shelter = Shelter.create(
      name: "Aurora shelter",
      city: "Aurora, CO",
      foster_program: false,
      rank: 9
    )
    @pet = Pet.create(
      adoptable: true,
      age: 1,
      breed: "sphynx",
      name: "Lucille Bald",
      shelter_id: @shelter.id
    )
  end

  describe "relationships" do
    it { should have_many(:application_pets) }
    it { should have_many(:pets).through(:application_pets) }
  end

  describe "validations" do
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:street_address) }
    it { should validate_presence_of(:city) }
    it { should validate_presence_of(:state) }
    it { should validate_presence_of(:zip_code) }
    it { should validate_presence_of(:description) }
  end

  it "initializes as status = In Progress" do
    expect(@application.status).to eq("In Progress")
  end

  it "can update the application status" do
    @application.pending
    expect(@application.status).to eq("Pending")
  end

  it "can adopt a pet" do
    @application.adopt(@pet.id)
    expect(@application.pets.include?(@pet)).to eq(true)
  end
end
