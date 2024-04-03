class AdoptionApplication < ApplicationRecord
  has_many :application_pets
  has_many :pets, through: :application_pets
  has_many :shelters, through: :application_shelters

  after_create :set_defaults

  validates :name, presence: true
  validates :street_address, presence: true
  validates :city, presence: true
  validates :state, presence: true
  validates :zip_code, presence: true
  validates :description, presence: true

  def set_defaults
    update(status: "In Progress")
  end

  def pending
    update(status: "Pending")
  end

  def adopt(pet_id)
    return if pet_id.nil?

    pet_to_adopt = Pet.find_by(id: pet_id)

    return if pet_to_adopt.nil? || pets.include?(pet_to_adopt)

    pets << pet_to_adopt
  end
end
