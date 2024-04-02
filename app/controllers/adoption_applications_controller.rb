class AdoptionApplicationsController < ApplicationController
  def index
  end

  def show
    @adoption_application = AdoptionApplication.find(params[:id])
    @pets = @adoption_application.pets
    @pets_search = params[:search].present ? Pet.search(params[:search]) : false
    @adoption_application.adopt(params[:adopt_pet_id])
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

  def update
    @adoption_application = AdoptionApplication.find(params[:id])

    @adoption_application.update(adoption_application_params)
    @adoption_application.pending

    redirect_to "/adoption_applications/#{params[:id]}"
  end

  private

  def adoption_application_params
    params.permit(:name, :street_address, :city, :state, :zip_code,
                  :description, :status)
  end
end
