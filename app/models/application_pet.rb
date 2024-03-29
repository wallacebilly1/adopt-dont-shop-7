class ApplicationPet < ApplicationRecord
  belongs_to :pet
  belongs_to :adoption_application
end
