class AdminAdoptionApplicationsController < ApplicationController
  def show
    @adoption_application = AdoptionApplication.find(params[:id])
    @application_pets = @adoption_application.application_pets
  end
end
