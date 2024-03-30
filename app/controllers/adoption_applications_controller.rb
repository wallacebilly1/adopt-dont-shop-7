class AdoptionApplicationsController < ApplicationController
  def index
    @adoption_applications = AdoptionApplication.all
  end

  def show
    @adoption_application = AdoptionApplication.find(params[:id])
  end

  def new

  end

  def create
    adoption_application = AdoptionApplication.create!(adoption_application_params)
    redirect_to "/adoption_applications/#{adoption_application.id}"
  end

private 
  def adoption_application_params
    params.permit(:name, :street_address, :city, :state, :zip_code, :description, :status)
  end
end
