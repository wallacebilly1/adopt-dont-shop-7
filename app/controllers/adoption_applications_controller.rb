class AdoptionApplicationsController < ApplicationController
  def index; end

  def show
    @adoption_application = AdoptionApplication.find(params[:id])
    @pets = ApplicationPet.pets_from_id(params[:id])
  end
end
