require "rails_helper"

RSpec.describe AdoptionApplication, type: :model do
  describe "relationships" do
    it { should have_many(:application_pets) }
    it { should have_many(:pets).through(:application_pets) }
  end

  # describe "validations" do
  #   it { should validate_presence_of(:name) }
  #   it { should validate_presence_of(:street_address) }
  #   it { should validate_presence_of(:city) }
  #   it { should validate_presence_of(:state) }
  #   it { should validate_numericality_of(:zip_code) }
  #   it { should validate_presence_of(:description) }
  #   it { should validate_presence_of(:status) }
  # end
end