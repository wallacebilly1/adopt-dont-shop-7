class ApplicationPet < ApplicationRecord
  belongs_to :pet
  belongs_to :adoption_application

  def self.pets_from_id(id)
    ApplicationPet.joins(:pet, :adoption_application)
                  .where("application_pets.adoption_application_id = #{id}")
                  .select("pets.*")
  end
end
