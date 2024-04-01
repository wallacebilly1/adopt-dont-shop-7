class ApplicationShelter < ApplicationRecord
  belongs_to :shelter
  belongs_to :adoption_application

  def self.shelters_with_pending_applications
    shelter_applications = {}
    application_join = joins(:adoption_application).joins(:shelter)
    application_join.each do |app_shelter_ar|
      if shelter_applications[app_shelter_ar.shelter].nil?
        shelter_applications[app_shelter_ar.shelter] =
          [app_shelter_ar.adoption_application]
      else
        unless shelter_applications[app_shelter_ar.shelter].include?(app_shelter_ar.adoption_application)
          shelter_applications[app_shelter_ar.shelter] << app_shelter_ar.adoption_application
        end
      end
    end
    shelter_applications
  end
end
