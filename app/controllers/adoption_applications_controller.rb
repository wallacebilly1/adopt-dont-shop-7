class AdoptionApplicationsController < ApplicationController
  def index
  end

  def show
    @adoption_application = AdoptionApplication.find(params[:id])
    @pet = Pet.find_by(name: params[:name])
    @pet = params[:name] if params[:name] && @pet.nil?
    p params
    @adoption_application.adopt(params[:adopt_pet_id]) if params[:adopt_pet_id]
  end

  def new
  end

  def create
    adoption_application = AdoptionApplication.new(adoption_application_params)

    if adoption_application.save
      redirect_to "/adoption_applications/#{adoption_application.id}"
    else
      # would be nice to have this message display lower on the page
      redirect_to "/adoption_applications/new"
      flash[:alert] = "Error: #{error_message(adoption_application.errors)}"
    end
  end

  private

  def adoption_application_params
    params.permit(:name, :street_address, :city, :state, :zip_code,
                  :description, :status)
  end
end
