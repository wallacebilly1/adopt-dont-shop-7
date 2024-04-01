class Shelter < ApplicationRecord
  validates :name, presence: true
  validates :rank, presence: true, numericality: true
  validates :city, presence: true

  has_many :pets, dependent: :destroy
  has_many :adoption_applications, through: :pets

  def self.order_by_recently_created
    order(created_at: :desc)
  end

  def self.order_by_number_of_pets
    select("shelters.*, count(pets.id) AS pets_count")
      .joins("LEFT OUTER JOIN pets ON pets.shelter_id = shelters.id")
      .group("shelters.id")
      .order("pets_count DESC")
  end

  def pet_count
    pets.count
  end

  def adoptable_pets
    pets.where(adoptable: true)
  end

  def alphabetical_pets
    adoptable_pets.order(name: :asc)
  end

  def shelter_pets_filtered_by_age(age_filter)
    adoptable_pets.where("age >= ?", age_filter)
  end

  def self.pending_applications
    application_data = {}
    all.each do |shelter|
      shelter.pets.each do |pet|
        pet.adoption_applications.each do |adoption_application|
          if application_data[shelter].nil?
            application_data[shelter] = [
              adoption_application
            ]
          else
            unless application_data[shelter].include?(adoption_application)
              application_data[shelter] << adoption_application
            end
          end
        end
      end
    end
    application_data
  end
end
